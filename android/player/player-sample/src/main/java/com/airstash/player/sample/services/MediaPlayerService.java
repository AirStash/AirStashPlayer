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
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.airstash.player.sample.services;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;
import android.support.annotation.Nullable;

import com.airstash.player.player.IMediaPlayer;

public class MediaPlayerService extends Service {
    private static IMediaPlayer sMediaPlayer;

    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context, MediaPlayerService.class);
        return intent;
    }

    public static void intentToStart(Context context) {
        context.startService(newIntent(context));
    }

    public static void intentToStop(Context context) {
        context.stopService(newIntent(context));
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    public static void setMediaPlayer(IMediaPlayer mp) {
        if (sMediaPlayer != null && sMediaPlayer != mp) {
            if (sMediaPlayer.isPlaying())
                sMediaPlayer.stop();
            sMediaPlayer.release();
            sMediaPlayer = null;
        }
        sMediaPlayer = mp;
    }

    public static IMediaPlayer getMediaPlayer() {
        return sMediaPlayer;
    }
}
