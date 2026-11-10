/*
 * Copyright (C) 2015 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.qualcomm.timeservice;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class TimeServiceBroadcastReceiver extends BroadcastReceiver {
    private static final String TAG = "TimeService";
    private static final String LIBRARY = "TimeService";

    private static boolean sLibraryLoaded = false;

    static {
        try {
            System.loadLibrary(LIBRARY);
            sLibraryLoaded = true;
        } catch (UnsatisfiedLinkError e) {
            Log.e(TAG, "Could not load lib" + LIBRARY + ".so: " + e);
        }
    }

    /*
     * Implemented in /system/vendor/lib/libTimeService.so. Does
     * time_genoff_operation(ATS_USER, TIME_MSEC, T_SET, time), which
     * tells time_daemon to persist the user time offset.
     */
    private native void setTimeServicesUserTime(long time);

    @Override
    public void onReceive(Context context, Intent intent) {
        if (!sLibraryLoaded) {
            return;
        }

        long currentTime = System.currentTimeMillis();
        Log.d(TAG, intent.getAction() + ": setting time services user time to " + currentTime);
        try {
            setTimeServicesUserTime(currentTime);
        } catch (Throwable t) {
            Log.e(TAG, "Could not set time services user time: " + t);
        }
    }
}
