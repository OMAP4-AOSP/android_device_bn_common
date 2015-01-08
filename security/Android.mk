ifeq ($(BOARD_USES_LOCAL_SECURE_SERVICES),true)
include $(call all-subdir-makefiles)
endif
