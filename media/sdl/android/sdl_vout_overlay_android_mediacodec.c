/*
 * This file is part of AirStashPlayer.
 * Copyright (c) 2016 Wearable Inc.
 *
 * AirStashPlayer is based on ijkPlayer:
 * Copyright (c) 2013-2014 Zhang Rui <bbcallen@gmail.com>
 *
 * Portions of ijkPlayer are based on kxmovie:
 * Copyright (c) 2012 Konstantin Boukreev. All rights reserved.
 *
 * AirStashPlayer is free software: you can redistribute it and/or
 * modify it under the terms of version 3 of the GNU Lesser General
 * Public License as published by the Free Software Foundation.
 *
 * AirStashPlayer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with AirStashPlayer.  If not, see
 * <http://www.gnu.org/licenses/>.
 */

#include "sdl_vout_overlay_android_mediacodec.h"
#include <assert.h>
#include "sdl/sdl_stdinc.h"
#include "sdl/sdl_mutex.h"
#include "sdl/sdl_vout_internal.h"
#include "sdl/sdl_video.h"
#include "sdl_vout_android_nativewindow.h"
#include "sdl_codec_android_mediacodec.h"
#include "sdl_inc_internal_android.h"

#ifndef AMCTRACE
#define AMCTRACE(...)
#endif

typedef struct SDL_VoutOverlay_Opaque {
    SDL_mutex *mutex;

    SDL_Vout                   *vout;
    SDL_AMediaCodec            *acodec;

    SDL_AMediaCodecBufferProxy *buffer_proxy;

    Uint16 pitches[AV_NUM_DATA_POINTERS];
    Uint8 *pixels[AV_NUM_DATA_POINTERS];
} SDL_VoutOverlay_Opaque;

static int overlay_lock(SDL_VoutOverlay *overlay)
{
    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;
    return SDL_LockMutex(opaque->mutex);
}

static int overlay_unlock(SDL_VoutOverlay *overlay)
{
    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;
    return SDL_UnlockMutex(opaque->mutex);
}

static void overlay_unref(SDL_VoutOverlay *overlay)
{
    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;

    SDL_VoutAndroid_releaseBufferProxyP(opaque->vout, &opaque->buffer_proxy, false);
}

static void overlay_free_l(SDL_VoutOverlay *overlay)
{
    AMCTRACE("SDL_Overlay(ffmpeg): overlay_free_l(%p)\n", overlay);
    if (!overlay)
        return;

    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;
    if (!opaque)
        return;

    overlay_unref(overlay);

    if (opaque->mutex)
        SDL_DestroyMutex(opaque->mutex);

    SDL_VoutOverlay_FreeInternal(overlay);
}

static SDL_Class g_vout_overlay_amediacodec_class = {
    .name = "AndroidMediaCodecVoutOverlay",
};

inline static bool check_object(SDL_VoutOverlay* object, const char *func_name)
{
    if (!object || !object->opaque || !object->opaque_class) {
        ALOGE("%s.%s: invalid pipeline\n", object->opaque_class->name, func_name);
        return false;
    }

    if (object->opaque_class != &g_vout_overlay_amediacodec_class) {
        ALOGE("%s.%s: unsupported method\n", object->opaque_class->name, func_name);
        return false;
    }

    return true;
}

static int func_fill_frame(SDL_VoutOverlay *overlay, const AVFrame *frame)
{
    assert(frame->format == SDL_FCC__AMC);

    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;

    if (!check_object(overlay, __func__))
        return -1;

    if (opaque->buffer_proxy)
        SDL_VoutAndroid_releaseBufferProxyP(opaque->vout, (SDL_AMediaCodecBufferProxy **)&opaque->buffer_proxy, false);

    opaque->acodec       = SDL_VoutAndroid_peekAMediaCodec(opaque->vout);
    // TODO: ref-count buffer_proxy?
    opaque->buffer_proxy = (SDL_AMediaCodecBufferProxy *)frame->opaque;

    overlay->opaque_class = &g_vout_overlay_amediacodec_class;
    overlay->format     = SDL_FCC__AMC;
    overlay->planes     = 1;
    overlay->pixels[0]  = NULL;
    overlay->pixels[1]  = NULL;
    overlay->pitches[0] = 0;
    overlay->pitches[1] = 0;
    overlay->is_private = 1;

    overlay->w = (int)frame->width;
    overlay->h = (int)frame->height;
    return 0;
}

SDL_VoutOverlay *SDL_VoutAMediaCodec_CreateOverlay(int width, int height, Uint32 format, SDL_Vout *vout)
{
    SDLTRACE("SDL_VoutAMediaCodec_CreateOverlay(w=%d, h=%d, fmt=%.4s(0x%x, vout=%p)\n",
        width, height, (const char*) &format, format, vout);
    SDL_VoutOverlay *overlay = SDL_VoutOverlay_CreateInternal(sizeof(SDL_VoutOverlay_Opaque));
    if (!overlay) {
        ALOGE("overlay allocation failed");
        return NULL;
    }

    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;
    opaque->mutex         = SDL_CreateMutex();
    opaque->vout          = vout;
    opaque->acodec        = NULL;
    opaque->buffer_proxy  = NULL;

    overlay->opaque_class = &g_vout_overlay_amediacodec_class;
    overlay->format       = format;
    overlay->pitches      = opaque->pitches;
    overlay->pixels       = opaque->pixels;
    overlay->w            = width;
    overlay->h            = height;
    overlay->is_private   = 1;

    overlay->free_l       = overlay_free_l;
    overlay->lock         = overlay_lock;
    overlay->unlock       = overlay_unlock;
    overlay->unref        = overlay_unref;
    overlay->func_fill_frame = func_fill_frame;

    switch (format) {
    case SDL_FCC__AMC: {
        break;
    }
    default:
        ALOGE("SDL_VoutAMediaCodec_CreateOverlay(...): unknown format %.4s(0x%x)\n", (char*)&format, format);
        goto fail;
    }

    return overlay;

fail:
    overlay_free_l(overlay);
    return NULL;
}

bool SDL_VoutOverlayAMediaCodec_isKindOf(SDL_VoutOverlay *overlay)
{
    return check_object(overlay, __func__);
}

int  SDL_VoutOverlayAMediaCodec_releaseFrame_l(SDL_VoutOverlay *overlay, SDL_AMediaCodec *acodec, bool render)
{
    if (!check_object(overlay, __func__))
        return -1;

    SDL_VoutOverlay_Opaque *opaque = overlay->opaque;
    return SDL_VoutAndroid_releaseBufferProxyP_l(opaque->vout, &opaque->buffer_proxy, render);
}
