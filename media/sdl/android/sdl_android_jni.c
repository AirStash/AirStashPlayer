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

#include "sdl_android_jni.h"

#include <unistd.h>
#include <sys/system_properties.h>
#include "sdl/android/AirStash/c/android/os/Build.h"
#include "sdl_inc_internal_android.h"
#include "sdl_codec_android_mediaformat_java.h"
#include "sdl_codec_android_mediacodec_java.h"

static JavaVM *g_jvm;

static pthread_key_t g_thread_key;
static pthread_once_t g_key_once = PTHREAD_ONCE_INIT;

JavaVM *SDL_JNI_GetJvm()
{
    return g_jvm;
}

static void SDL_JNI_ThreadDestroyed(void* value)
{
    JNIEnv *env = (JNIEnv*) value;
    if (env != NULL) {
        ALOGE("%s: [%d] didn't call SDL_JNI_DetachThreadEnv() explicity\n", __func__, (int)gettid());
        (*g_jvm)->DetachCurrentThread(g_jvm);
        pthread_setspecific(g_thread_key, NULL);
    }
}

static void make_thread_key()
{
    pthread_key_create(&g_thread_key, SDL_JNI_ThreadDestroyed);
}

jint SDL_JNI_SetupThreadEnv(JNIEnv **p_env)
{
    JavaVM *jvm = g_jvm;
    if (!jvm) {
        ALOGE("SDL_JNI_GetJvm: AttachCurrentThread: NULL jvm");
        return -1;
    }

    pthread_once(&g_key_once, make_thread_key);

    JNIEnv *env = (JNIEnv*) pthread_getspecific(g_thread_key);
    if (env) {
        *p_env = env;
        return 0;
    }

    if ((*jvm)->AttachCurrentThread(jvm, &env, NULL) == JNI_OK) {
        pthread_setspecific(g_thread_key, env);
        *p_env = env;
        return 0;
    }

    return -1;
}

void SDL_JNI_DetachThreadEnv()
{
    JavaVM *jvm = g_jvm;

    ALOGI("%s: [%d]\n", __func__, (int)gettid());

    pthread_once(&g_key_once, make_thread_key);

    JNIEnv *env = pthread_getspecific(g_thread_key);
    if (!env)
        return;
    pthread_setspecific(g_thread_key, NULL);

    if ((*jvm)->DetachCurrentThread(jvm) == JNI_OK)
        return;

    return;
}

int SDL_JNI_ThrowException(JNIEnv* env, const char* className, const char* msg)
{
    if ((*env)->ExceptionCheck(env)) {
        jthrowable exception = (*env)->ExceptionOccurred(env);
        (*env)->ExceptionClear(env);

        if (exception != NULL) {
            ALOGW("Discarding pending exception (%s) to throw", className);
            (*env)->DeleteLocalRef(env, exception);
        }
    }

    jclass exceptionClass = (*env)->FindClass(env, className);
    if (exceptionClass == NULL) {
        ALOGE("Unable to find exception class %s", className);
        /* ClassNotFoundException now pending */
        goto fail;
    }

    if ((*env)->ThrowNew(env, exceptionClass, msg) != JNI_OK) {
        ALOGE("Failed throwing '%s' '%s'", className, msg);
        /* an exception, most likely OOM, will now be pending */
        goto fail;
    }

    return 0;
fail:
    if (exceptionClass)
        (*env)->DeleteLocalRef(env, exceptionClass);
    return -1;
}

int SDL_JNI_ThrowIllegalStateException(JNIEnv *env, const char* msg)
{
    return SDL_JNI_ThrowException(env, "java/lang/IllegalStateException", msg);
}

jobject SDL_JNI_NewObjectAsGlobalRef(JNIEnv *env, jclass clazz, jmethodID methodID, ...)
{
    va_list args;
    va_start(args, methodID);

    jobject global_object = NULL;
    jobject local_object = (*env)->NewObjectV(env, clazz, methodID, args);
    if (!AirStash_ExceptionCheck__throwAny(env) && local_object) {
        global_object = (*env)->NewGlobalRef(env, local_object);
        SDL_JNI_DeleteLocalRefP(env, &local_object);
    }

    va_end(args);
    return global_object;
}

void SDL_JNI_DeleteGlobalRefP(JNIEnv *env, jobject *obj_ptr)
{
    if (!obj_ptr || !*obj_ptr)
        return;

    (*env)->DeleteGlobalRef(env, *obj_ptr);
    *obj_ptr = NULL;
}

void SDL_JNI_DeleteLocalRefP(JNIEnv *env, jobject *obj_ptr)
{
    if (!obj_ptr || !*obj_ptr)
        return;

    (*env)->DeleteLocalRef(env, *obj_ptr);
    *obj_ptr = NULL;
}


int SDL_Android_GetApiLevel()
{
    static int SDK_INT = 0;
    if (SDK_INT > 0)
        return SDK_INT;

    JNIEnv *env = NULL;
    if (JNI_OK != SDL_JNI_SetupThreadEnv(&env)) {
        ALOGE("SDL_Android_GetApiLevel: SetupThreadEnv failed");
        return 0;
    }

    SDK_INT = AirStashC_android_os_Build__VERSION__SDK_INT__get__catchAll(env);
    ALOGI("API-Level: %d\n", SDK_INT);
    return SDK_INT;
#if 0
    char value[PROP_VALUE_MAX];
    memset(value, 0, sizeof(value));
    __system_property_get("ro.build.version.sdk", value);
    SDK_INT = atoi(value);
    return SDK_INT;
#endif
}


JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *reserved)
{
    int retval;
    JNIEnv* env = NULL;

    g_jvm = vm;
    if ((*vm)->GetEnv(vm, (void**) &env, JNI_VERSION_1_4) != JNI_OK) {
        return -1;
    }

    retval = AirStash_LoadAll__catchAll(env);
    JNI_CHECK_RET(retval == 0, env, NULL, NULL, -1);

    return JNI_VERSION_1_4;
}

JNIEXPORT void JNICALL JNI_OnUnload(JavaVM *jvm, void *reserved)
{
}
