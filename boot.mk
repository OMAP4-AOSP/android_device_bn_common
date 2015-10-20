#
# Copyright (C) 2011 The Cyanogenmod Project
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
#

#
# Ramdisk/boot image
#
LOCAL_PATH := $(call my-dir)

MASTER_KEY := $(DEVICE_FOLDER)/prebuilt/boot/master_boot.key
MASTER_RECOVERY_KEY := $(DEVICE_FOLDER)/prebuilt/boot/master_recovery.key

# this is a copy of the build/core/Makefile target
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(MASTER_KEY)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) \
																--output $@.temp
	$(hide) cp $(MASTER_KEY) $@; dd if=$@.temp of=$@ bs=1048576 seek=1; rm $@.temp
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

#
# Recovery Image
#
$(INSTALLED_RECOVERYIMAGE_TARGET): \
			$(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel) $(MASTER_RECOVERY_KEY)
	$(call build-recoveryimage-target, $@)
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) \
																		--output $@.temp
	$(hide) cp $(MASTER_RECOVERY_KEY) $@; dd if=$@.temp of=$@ bs=1048576 seek=1; rm $@.temp
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
