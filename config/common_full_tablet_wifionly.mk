# Inherit mobile full common LESSAOSP stuff
$(call inherit-product, vendor/lessaosp/config/common_mobile_full.mk)

# Inherit tablet common LESSAOSP stuff
$(call inherit-product, vendor/lessaosp/config/tablet.mk)

$(call inherit-product, vendor/lessaosp/config/wifionly.mk)
