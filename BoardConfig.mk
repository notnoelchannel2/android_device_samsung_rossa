# Inherit from common
include device/samsung/qcom-common/BoardConfigCommon.mk

# Includes from vendor
-include vendor/samsung/rossa/BoardConfigVendor.mk

LOCAL_PATH := device/samsung/rossa

# Asserts
TARGET_OTA_ASSERT_DEVICE := rossa,coreprimeltexx,rossaxx

# Init
# cm-13.0: device/qcom/common no longer builds libinit_msm, so init/ carries
# a port of it (same behaviour as cm-12.1).
# cm-12.1 used: TARGET_INIT_VENDOR_LIB := libinit_msm
TARGET_INIT_VENDOR_LIB := libinit_rossa
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/

# Kernel
# cm-13.0: kernel/samsung/rossa is android_kernel_samsung_rossa-2 (3.10.108 +
# SELinux policy v30 support, needed to load Marshmallow's sepolicy).
# cm-12.1 used: TARGET_KERNEL_SOURCE := kernel/samsung/coreprimelte
TARGET_KERNEL_SOURCE := kernel/samsung/rossa
TARGET_KERNEL_CONFIG := msm8916_sec_defconfig
TARGET_KERNEL_SELINUX_CONFIG := selinux_defconfig
TARGET_KERNEL_VARIANT_CONFIG := msm8916_sec_rossa_eur_defconfig

BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk
BOARD_DTBTOOL_ARGS := -2
BOARD_KERNEL_SEPARATED_DT := true
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x02000000
BOARD_KERNEL_TAGS_OFFSET := 0x01e00000
BOARD_SECOND_OFFSET := 0x00f0000

BOARD_KERNEL_CMDLINE += \
	console=null \
	androidboot.hardware=qcom \
	user_debug=31 \
	msm_rtb.filter=0x3F \
	ehci-hcd.park=3 \
	androidboot.bootdevice=7824900.sdhci \
	androidboot.selinux=permissive

# Platform
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_CORTEX_A53 := true
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_BOARD_PLATFORM := msm8916
TARGET_BOARD_PLATFORM_GPU := qcom-adreno306
FORCE_32_BIT := true


# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8916

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 13631488
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 15728640
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1237319680
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5816430592
BOARD_CACHEIMAGE_PARTITION_SIZE := 524288000
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4

# Vold
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
BOARD_VOLD_MAX_PARTITIONS := 67
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Audio
AUDIO_FEATURE_DEEP_BUFFER_RINGTONE := true
AUDIO_FEATURE_ENABLED_KPI_OPTIMIZE := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
AUDIO_FEATURE_ENABLED_FLAC_OFFLOAD := false
BOARD_USES_ALSA_AUDIO := true

# RIL
TARGET_RIL_VARIANT := caf
# cm-13.0: ril13/ holds the Marshmallow SamsungQcomRIL (from Galaxy-MSM8916
# msm8916-common cm-13.0); ril/ keeps the Lollipop class for cm-12.1.
BOARD_RIL_CLASS := ../../../$(LOCAL_PATH)/ril13
# Don't set BOARD_PROVIDES_LIBRIL here, even though Galaxy-MSM8916's
# msm8916-common does: it stops hardware/ril-caf building libril, and nothing
# in this tree replaces it, so rild has no libril to link against.
# hardware/samsung's libril is only built for the modems listed in
# ril/Android.mk (m7450, mdm9x35, ss333, tss310, xmm*), and msm8916's
# integrated modem is not one of them. The vendor tree's libril.so is copied
# into place with PRODUCT_COPY_FILES, which installs a file but provides no
# module to link. Same as cm-12.1.
PROTOBUF_SUPPORTED := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# Camera (wrapper around the stock HAL, see camera/)
TARGET_PROVIDES_CAMERA_HAL := true
USE_DEVICE_SPECIFIC_CAMERA := true

# GPS (HAL source matched to the Samsung loc blobs, see gps/)
USE_DEVICE_SPECIFIC_GPS := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# malloc implementation
MALLOC_IMPL := dlmalloc

# Power
TARGET_POWERHAL_VARIANT := qcom

# NFC (Samsung N5, /dev/sec-nfc)
BOARD_HAVE_NFC := true
BOARD_NFC_HAL_SUFFIX := msm8916

# FM
AUDIO_FEATURE_ENABLED_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# Display
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
TARGET_CONTINUOUS_SPLASH_ENABLED := true
TARGET_USES_QCOM_BSP := true

# cm-13.0 caf-8916 HALs: the kernel uses the new ION API (heap_id_mask)
TARGET_USES_NEW_ION_API := true

   
TARGET_QCOM_DISPLAY_VARIANT := caf
TARGET_QCOM_AUDIO_VARIANT := caf
TARGET_QCOM_MEDIA_VARIANT := caf

# Qualcomm support
HAVE_SYNAPTICS_I2C_RMI4_FW_UPGRADE   := true
USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME := "wlan"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP := "ap"
WPA_SUPPLICANT_VERSION := VER_0_8_X
TARGET_USES_WCNSS_CTRL := true

WLAN_MODULES:
	mkdir -p $(KERNEL_MODULES_OUT)/pronto
	mv $(KERNEL_MODULES_OUT)/wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko
	ln -sf /system/lib/modules/pronto/pronto_wlan.ko $(TARGET_OUT)/lib/modules/wlan.ko

TARGET_KERNEL_MODULES += WLAN_MODULES

# Time services
BOARD_USES_QC_TIME_SERVICES := true

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_RECOVERY_SWIPE := true
BOARD_USES_MMCUTILS := true
BOARD_SUPPRESS_EMMC_WIPE := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
TARGET_RECOVERY_DENSITY := hdpi
TARGET_RECOVERY_QCOM_RTC_FIX := true

TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/recovery.fstab

# SELinux (cm-13.0). The kernel cmdline keeps androidboot.selinux=permissive
# for bring-up; the policy below is from Galaxy-MSM8916 msm8916-common cm-13.0.
-include device/qcom/sepolicy/sepolicy.mk
-include vendor/cm/sepolicy/sepolicy.mk
-include vendor/cm/sepolicy/qcom/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/sepolicy
