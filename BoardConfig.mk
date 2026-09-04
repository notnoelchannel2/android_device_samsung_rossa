# Inherit from common
include device/samsung/rossa-common/BoardConfigCommon.mk

LOCAL_PATH := device/samsung/rossa

# Asserts
TARGET_OTA_ASSERT_DEVICE := rossa,coreprimelte,coreprimeltexx

# Kernel
TARGET_KERNEL_VARIANT_CONFIG := recovery_msm8916_sec_rossa_eur_defconfig

# Partition sizes
BOARD_SYSTEMIMAGE_PARTITION_SIZE    := 1237319680
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 5816430592
DEVICE_CACHEIMAGE_PARTITION_SIZE    := 524288000

# Properties
TARGET_SYSTEM_PROP += $(LOCAL_PATH)/system.prop
