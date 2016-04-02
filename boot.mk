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

MASTER_KEY := $(COMMON_FOLDER)/prebuilt/boot/stack.key
BOOT_BIN := $(DEVICE_FOLDER)/prebuilt/boot/boot.bin
RECO_BIN := $(DEVICE_FOLDER)/prebuilt/boot/reco.bin
MY_TAG = "eMMC $(@F)+secondloader for $(TARGET_DEVICE)"

# this is a copy of the build/core/Makefile target
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(MASTER_KEY)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) \
																--output $@.orig
	$(hide) cp $(BOOT_BIN) $@.bin; dd if=$(MASTER_KEY) of=$@.bin bs=782480 seek=1 \
		conv=notrunc; $(MKBOOTIMG) --kernel $@.bin --ramdisk /dev/null --cmdline \
		$(MY_TAG) --ramdisk_offset 0x1000000 --pagesize 4096 --base 0x80d78000 -o $@; \
		cp $@ $@.key; dd if=$@.orig of=$@ bs=1048576 seek=1; rm $@.bin
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

#
# Recovery Image
#
$(INSTALLED_RECOVERYIMAGE_TARGET): \
			$(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel) $(MASTER_KEY)
	$(call build-recoveryimage-target, $@)
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) \
																		--output $@.orig
	$(hide) cp $(RECO_BIN) $@.bin; dd if=$(MASTER_KEY) of=$@.bin bs=782480 seek=1 \
		conv=notrunc; $(MKBOOTIMG) --kernel $@.bin --ramdisk /dev/null --cmdline \
		$(MY_TAG) --ramdisk_offset 0x1000000 --pagesize 4096 --base 0x80d78000 -o $@; \
		cp $@ $@.key; dd if=$@.orig of=$@ bs=1048576 seek=1; rm $@.bin
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
