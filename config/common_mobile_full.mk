# Inherit common LESSAOSP stuff
$(call inherit-product, vendor/lessaosp/config/common_mobile.mk)

PRODUCT_SIZE := full

# Include LessAOSP LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/lessaosp/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/lessaosp/overlay/dictionaries
