# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

$(call inherit-product, device/samsung/rossa/full_rossa.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=rossa TARGET_DEVICE=rossa

PRODUCT_NAME := cm_rossa
