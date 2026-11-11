#
# Copyright (C) 2026 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from common (Galaxy-MSM8916 coreprimelte-common -> msm8916-common)
include device/samsung/coreprimelte-common/BoardConfigCommon.mk

LOCAL_PATH := device/samsung/rossa

# Asserts
TARGET_OTA_ASSERT_DEVICE := rossa,coreprimelte,coreprimeltexx,rossaxx

# Init: the common init only knows the SM-G360P; detect the SM-G360F here
TARGET_LIBINIT_MSM8916_DEFINES_FILE := $(LOCAL_PATH)/init/init_rossa.cpp

# Kernel (Galaxy-MSM8916/android_kernel_samsung_msm8916, cm-14.1, plus
# patches/kernel/0001-msm8916-Add-rossa-EUR-SM-G360F-variant.patch)
TARGET_KERNEL_VARIANT_CONFIG := msm8916_sec_rossa_eur_defconfig

# Partition sizes (SM-G360F, 8 GB eMMC)
BOARD_SYSTEMIMAGE_PARTITION_SIZE    := 1237319680
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 5816430592
DEVICE_CACHEIMAGE_PARTITION_SIZE    := 524288000

# Properties
TARGET_SYSTEM_PROP += $(LOCAL_PATH)/system.prop
