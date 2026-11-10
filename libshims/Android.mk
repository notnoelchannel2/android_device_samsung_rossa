LOCAL_PATH := $(call my-dir)

# libqcicu: provides the ICU 51 entry points that the prebuilt
# /vendor/lib/libqc-opt.so was linked against, forwarding them to the
# platform's ICU (53 on CM 12.1). libqc-opt.so is patched to load this
# library in place of libicuuc.so; libqcicu itself depends on libicuuc.
include $(CLEAR_VARS)

LOCAL_SRC_FILES := icu51.c
LOCAL_C_INCLUDES := external/icu/icu4c/source/common
LOCAL_SHARED_LIBRARIES := libicuuc
LOCAL_MODULE := libqcicu
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -Wall -Werror

include $(BUILD_SHARED_LIBRARY)
