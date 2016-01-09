# Copyright (C) Texas Instruments - http://www.ti.com/
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

ifeq ($(BOARD_USE_CUSTOM_HWC),true)

LOCAL_PATH := $(call my-dir)

# HAL module implementation, not prelinked and stored in
# hw/<HWCOMPOSE_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/../vendor/lib/hw
LOCAL_SHARED_LIBRARIES := liblog libEGL libcutils libutils libhardware libhardware_legacy libz

LOCAL_SRC_FILES := hwc.c rgz_2d.c dock_image.c sw_vsync.c

ifeq ($(BOARD_USE_TI_LIBION),true)
LOCAL_SHARED_LIBRARIES += libion_ti
LOCAL_C_INCLUDES += $(OMAP4_NEXT_FOLDER)/include
else
LOCAL_SHARED_LIBRARIES += libion
LOCAL_SRC_FILES += ../../../../$(OMAP4_NEXT_FOLDER)/libion/ion_ti_custom.c
LOCAL_C_INCLUDES += $(OMAP4_NEXT_FOLDER)/libion
endif

LOCAL_STATIC_LIBRARIES := libpng

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := hwcomposer.$(TARGET_BOOTLOADER_BOARD_NAME)
LOCAL_CFLAGS := -DLOG_TAG=\"ti_hwc\"
LOCAL_C_INCLUDES += external/libpng external/zlib

LOCAL_C_INCLUDES += \
    $(OMAP4_NEXT_FOLDER)/edid/inc \
    $(LOCAL_PATH)/../include
LOCAL_SHARED_LIBRARIES += libedid

# LOG_NDEBUG=0 means verbose logging enabled
# LOCAL_CFLAGS += -DLOG_NDEBUG=0
include $(BUILD_SHARED_LIBRARY)

endif
