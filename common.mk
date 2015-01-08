# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file includes all definitions that apply to ALL Amazon Kindle Fire devices, and
# are also specific to otter devices
#
# Everything in this directory will become public

COMMON_FOLDER := device/bn/common

# set to allow building from omap4-common
BOARD_VENDOR := bn

# add common overlays
DEVICE_PACKAGE_OVERLAYS += $(COMMON_FOLDER)/overlay/aosp

# Setup custom omap4xxx defines
BOARD_USE_CUSTOM_LIBION := true

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := $(DEVICE_FOLDER)/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Rootfs
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/init.omap4.rc:/root/init.omap4.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(call add-to-product-copy-files-if-exists,packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml)

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=120 \
    ro.opengles.version=131072 \
    com.ti.omap_enhancement=true \
    omap.enhancement=true \
    ro.crypto.state=unencrypted \
    persist.sys.usb.config=mtp,adb \
    persist.sys.root_access=3 \
    ro.sf.lcd_density=240 \
    ro.nf.profile=2 \
    ro.nf.level=512 \
    ro.bq.gpu_to_cpu_unsupported=1 \
    media.stagefright.cache-params=18432/20480/15 \
    ro.ksm.default=1 \
    telephony.sms.send=false

PRODUCT_CHARACTERISTICS := tablet

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Rootfs
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Wifi
PRODUCT_PACKAGES += \
    wpa_supplicant \
    ti_wfd_libs \
    dhcpcd.conf \
    lib_driver_cmd_wl12xx \
    TQS_D_1.7.ini \
    calibrator

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    sdcard \
    setup_fs \
    e2fsck \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs

# Audio Support
PRODUCT_PACKAGES += \
    libaudioutils \
    Music \
    tinyplay \
    tinymix \
    tinycap \
    audio_policy.default \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

# DRM
PRODUCT_PACKAGES += \
    libwvm \

# Misc / Testing
PRODUCT_PACKAGES += \
    strace \
    libjni_pinyinime \
    sh \
    libcorkscrew

# symlinks and pvr files
PRODUCT_PACKAGES += \
    libion.so \
    pvrsrvinit \
    libPVRScopeServices.so

PRODUCT_AAPT_PREF_CONFIG := hdpi
# BT
PRODUCT_PACKAGES += \
    uim-sysfs \
    libbt-vendor

# Prebuilts /system/etc
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/etc/audio_policy.conf:/system/etc/audio_policy.conf \
    $(COMMON_FOLDER)/prebuilt/etc/media_codecs.xml:/system/etc/media_codecs.xml \
    $(COMMON_FOLDER)/prebuilt/etc/media_profiles.xml:/system/etc/media_profiles.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \
    $(COMMON_FOLDER)/prebuilt/etc/mixer_paths.xml:/system/etc/mixer_paths.xml \
    $(COMMON_FOLDER)/prebuilt/etc/smc_normal_world_android_cfg.ini:/system/etc/smc_normal_world_android_cfg.ini \

# Input
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/usr/idc/ft5x06-i2c.idc:system/usr/idc/ft5x06-i2c.idc \
    $(COMMON_FOLDER)/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl


# USB Host app switcher
#PRODUCT_PACKAGES += USBHostSwitcher

# TI OMAP4
PRODUCT_PACKAGES += \
    libdomx \
    libOMX_Core \
    libOMX.TI.DUCATI1.VIDEO.H264E \
    libOMX.TI.DUCATI1.VIDEO.H264SVCE \
    libOMX.TI.DUCATI1.VIDEO.VC1E \
    libOMX.TI.DUCATI1.VIDEO.MPEG4E \
    libOMX.TI.DUCATI1.VIDEO.DECODER \
    libOMX.TI.DUCATI1.VIDEO.DECODER.secure \
    libOMX.TI.DUCATI1.VIDEO.CAMERA \
    libOMX.TI.DUCATI1.MISC.SAMPLE \
    libstagefrighthw \
    libI420colorconvert \
    libtiutils_custom \
    libion_ti \
    smc_pa_ctrl \
    tf_daemon \
    libtf_crypto_sst

# Hardware HALs
PRODUCT_PACKAGES += \
    hwcomposer.$(TARGET_BOOTLOADER_BOARD_NAME) \
    lights.$(TARGET_BOOTLOADER_BOARD_NAME) \
    power.$(TARGET_BOOTLOADER_BOARD_NAME) \
    audio.primary.$(TARGET_BOOTLOADER_BOARD_NAME) \
    sensors.$(TARGET_BOOTLOADER_BOARD_NAME) \
    audio.hdmi.$(TARGET_BOOTLOADER_BOARD_NAME)

ifeq ($(BN_CAMERA_STUB),true)
PRODUCT_PACKAGES += \
    camera.$(TARGET_BOOTLOADER_BOARD_NAME)
endif

# Clears the boot counter, update mac address on first start
PRODUCT_COPY_FILES += \
        $(COMMON_FOLDER)/prebuilt/bin/clear_bootcnt.sh:/system/bin/clear_bootcnt.sh \
	$(COMMON_FOLDER)/prebuilt/bin/fix-mac.sh:/system/bin/fix-mac.sh

# Art
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/poetry/poem.txt:root/sbin/poem.txt

$(call inherit-product-if-exists, vendor/bn/omap4470-common/omap4470-common-vendor.mk)
$(call inherit-product, hardware/ti/wlan/mac80211/wl127x-wlan-products.mk)
$(call inherit-product-if-exists, hardware/ti/wpan/ti-wpan-products.mk)
