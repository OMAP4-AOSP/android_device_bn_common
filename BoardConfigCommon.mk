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

COMMON_FOLDER := device/bn/common

# inherit from the proprietary version
-include vendor/bn/omap4470-common/BoardConfigVendor.mk

# set to allow building from omap4-common
BOARD_VENDOR := bn

PRODUCT_VENDOR_KERNEL_HEADERS := $(COMMON_FOLDER)/kernel-headers

TARGET_SPECIFIC_HEADER_PATH := $(COMMON_FOLDER)/include

USE_CAMERA_STUB := true
BOARD_HAVE_FAKE_GPS := true
BOARD_HAVE_BLUETOOTH := true
BOARD_WPAN_DEVICE := true


# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk
BOARD_USES_GENERIC_AUDIO := false

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(COMMON_FOLDER)/bluetooth

# Setup custom omap4xxx defines
BOARD_USE_CUSTOM_LIBION := true

# TI Enhancement Settings (Part 1)
OMAP_ENHANCEMENT := true
#OMAP_ENHANCEMENT_BURST_CAPTURE := true
#OMAP_ENHANCEMENT_S3D := true
#OMAP_ENHANCEMENT_CPCAM := true
#OMAP_ENHANCEMENT_VTC := true
OMAP_ENHANCEMENT_MULTIGPU := true
BOARD_USE_TI_ENHANCED_DOMX := true

# Processor
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_BOARD_PLATFORM := omap4
TARGET_ARCH_VARIANT := armv7-a-neon

# Wifi
USES_TI_MAC80211 := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X_TI
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_wl12xx
BOARD_WLAN_DEVICE                := wl12xx_mac80211
BOARD_SOFTAP_DEVICE              := wl12xx_mac80211
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wl12xx_sdio"
WIFI_FIRMWARE_LOADER             := ""
PRODUCT_WIRELESS_TOOLS           := true
COMMON_GLOBAL_CFLAGS		 += -DUSES_TI_MAC80211


# Kernel
BOARD_KERNEL_BASE := 0x80000000
TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := androidboot.console=ttyO0 console=ttyO0,115200n8 def_disp=lcd2

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 15728640
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 641728512
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12949893120
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_VOLD_MAX_PARTITIONS := 32
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"

ifndef BOARD_EGL_CFG
BOARD_EGL_CFG := $(COMMON_FOLDER)/prebuilt/etc/egl.cfg
endif

# Custom DOMX
TI_CUSTOM_DOMX_PATH := $(COMMON_FOLDER)/domx
DOMX_PATH := $(COMMON_FOLDER)/domx

# adb has root
ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.allow.mock.location=1

# Disable scissor optimisation - helps with scrolling performance
ADDITIONAL_DEFAULT_PROPERTIES += ro.hwui.disable_scissor_opt=true

# Graphics
USE_OPENGL_RENDERER := true
# set if the target supports FBIO_WAITFORVSYNC
TARGET_HAS_WAITFORVSYNC := true

TARGET_RECOVERY_PRE_COMMAND := "echo 'recovery' > /bootdata/BCB; sync"

# TI Enhancement Settings (Part 2)
ifdef BOARD_USE_TI_ENHANCED_DOMX
    BOARD_USE_TI_DUCATI_H264_PROFILE := true
    COMMON_GLOBAL_CFLAGS += -DENHANCED_DOMX
    ENHANCED_DOMX := true
else
    DOMX_PATH := hardware/ti/omap4xxx/domx
endif

ifdef OMAP_ENHANCEMENT
    COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP4
endif

ifdef OMAP_ENHANCEMENT_BURST_CAPTURE
    COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT_BURST_CAPTURE
endif

ifdef OMAP_ENHANCEMENT_S3D
    COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT_S3D
endif

ifdef OMAP_ENHANCEMENT_CPCAM
    COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT_CPCAM
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/sdk_addon/ti_omap_addon.mk
endif

ifdef OMAP_ENHANCEMENT_VTC
    COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT_VTC
endif

ifdef USE_ITTIAM_AAC
    COMMON_GLOBAL_CFLAGS += -DUSE_ITTIAM_AAC
endif

ifdef OMAP_ENHANCEMENT_MULTIGPU
    COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT_MULTIGPU
endif


# Misc.
BOARD_NEEDS_CUTILS_LOG := true
BOARD_USES_SECURE_SERVICES := true

# CodeAurora Optimizations: msm8960: Improve performance of memmove, bcopy, and memmove_words
# added by twa_priv
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION := true
TARGET_USE_KRAIT_PLD_SET := true
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_UMS_LUNFILE := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun/file"
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
# For bigger CWM font
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_15x24.h\"
RECOVERY_NAME := EMMC CWM-based recovery

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true

# TWRP stuff
TW_NO_REBOOT_BOOTLOADER := true
TW_NO_REBOOT_RECOVERY := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
RECOVERY_SDCARD_ON_DATA := true
TW_EXTERNAL_STORAGE_PATH := "/sdcard"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard"
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_BRIGHTNESS_PATH := /sys/class/backlight/lcd-backlight/brightness
TW_CUSTOM_POWER_BUTTON := 107
TW_MAX_BRIGHTNESS := 254
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/bq27500-0
