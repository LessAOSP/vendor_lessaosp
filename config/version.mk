# Copyright (C) 2021 VoltageOS
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

ANDROID_VERSION := 16
LESSAOSPVERSION := 1.0
LESSAOSP_BUILD_ROM_TYPE := VANILLA

LESSAOSP_BUILD_TYPE ?= UNOFFICIAL
LESSAOSP_DATE_YEAR := $(shell date -u +%Y)
LESSAOSP_DATE_MONTH := $(shell date -u +%m)
LESSAOSP_DATE_DAY := $(shell date -u +%d)
LESSAOSP_DATE_HOUR := $(shell date -u +%H)
LESSAOSP_DATE_MINUTE := $(shell date -u +%M)
LESSAOSP_BUILD_DATE := $(LESSAOSP_DATE_YEAR)$(LESSAOSP_DATE_MONTH)$(LESSAOSP_DATE_DAY)-$(LESSAOSP_DATE_HOUR)$(LESSAOSP_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst lessaosp_,,$(LESSAOSP_BUILD))

# GAPPS
LESSAOSP_GAPPS ?= false
ifeq ($(LESSAOSP_GAPPS), true)
    ifeq ($(LESSAOSP_GO), true)
        $(call inherit-product, vendor/partner_gms/products/gms_go_2gb.mk)
    else
        $(call inherit-product, vendor/partner_gms/products/gms.mk)
    endif
    LESSAOSP_BUILD_ROM_TYPE := GAPPS
endif

# OFFICIAL_DEVICES
ifeq ($(LESSAOSP_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/lessaosp/lessaosp.devices)
    ifeq ($(filter $(LESSAOSP_BUILD), $(LIST)), $(LESSAOSP_BUILD))
      IS_OFFICIAL=true
      LESSAOSP_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      LESSAOSP_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(LESSAOSP_BUILD)")
    endif
endif

LESSAOSP_VERSION := $(LESSAOSPVERSION)-$(LESSAOSP_BUILD)-$(LESSAOSP_BUILD_DATE)-$(LESSAOSP_BUILD_TYPE)-$(LESSAOSP_BUILD_ROM_TYPE)
LESSAOSP_MOD_VERSION :=$(ANDROID_VERSION)-$(LESSAOSPVERSION)
LESSAOSP_DISPLAY_VERSION := LessAOSP-$(LESSAOSPVERSION)-$(LESSAOSP_BUILD_TYPE)-$(LESSAOSP_BUILD_ROM_TYPE)
LESSAOSP_DISPLAY_BUILDTYPE := $(LESSAOSP_BUILD_TYPE)
LESSAOSP_FINGERPRINT := LessAOSP/$(LESSAOSP_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(LESSAOSP_BUILD_DATE)
LESSAOSP_PLATFORM_RELEASE_OR_CODENAME := 16.0

# LessAOSP System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.lessaosp.version=$(LESSAOSP_DISPLAY_VERSION) \
  ro.lessaosp.build.status=$(LESSAOSP_BUILD_TYPE) \
  ro.modversion=$(LESSAOSP_MOD_VERSION) \
  ro.lessaosp.build.date=$(LESSAOSP_BUILD_DATE) \
  ro.lessaosp.buildtype=$(LESSAOSP_BUILD_TYPE) \
  ro.lessaosp.fingerprint=$(LESSAOSP_FINGERPRINT) \
  ro.lessaosp.device=$(LESSAOSP_BUILD) \
  ro.lessaosp.platform_release_or_codename=$(LESSAOSP_PLATFORM_RELEASE_OR_CODENAME) \
  org.lessaosp.version=$(LESSAOSPVERSION) \
  ro.lessaosp.romtype=$(LESSAOSP_BUILD_ROM_TYPE)
