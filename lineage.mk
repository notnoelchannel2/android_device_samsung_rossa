
# Inherit from common
$(call inherit-product, device/samsung/rossa-common/lineage.mk)

$(call inherit-product, device/samsung/rossa/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := rossa
PRODUCT_NAME := lineage_rossa
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-G360F
PRODUCT_MANUFACTURER := samsung
PRODUCT_CHARACTERISTICS := phone

PRODUCT_GMS_CLIENTID_BASE := android-samsung
