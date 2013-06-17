export

## NOTE
## Make sure to have each variable declaration start
## in the first column, no whitespace allowed.

ifeq ($(wildcard $(KLIB_BUILD)/.config),)
# These will be ignored by compat autoconf
 CONFIG_PCI=y
 CONFIG_USB=y
 CONFIG_PCMCIA=y
 CONFIG_SSB=m
else
include $(KLIB_BUILD)/.config
endif

ifneq ($(wildcard $(KLIB_BUILD)/Makefile),)

COMPAT_LATEST_VERSION = 1

KERNEL_VERSION := $(shell $(MAKE) -C $(KLIB_BUILD) kernelversion | sed -n 's/^\([0-9]\)\..*/\1/p')

ifneq ($(KERNEL_VERSION),2)
KERNEL_SUBLEVEL := $(shell $(MAKE) -C $(KLIB_BUILD) kernelversion | sed -n 's/^3\.\([0-9]\+\).*/\1/p')
else
COMPAT_26LATEST_VERSION = 39
KERNEL_26SUBLEVEL := $(shell $(MAKE) -C $(KLIB_BUILD) kernelversion | sed -n 's/^2\.6\.\([0-9]\+\).*/\1/p')
COMPAT_26VERSIONS := $(shell I=$(COMPAT_26LATEST_VERSION); while [ "$$I" -gt $(KERNEL_26SUBLEVEL) ]; do echo $$I; I=$$(($$I - 1)); done)
$(foreach ver,$(COMPAT_26VERSIONS),$(eval CONFIG_COMPAT_KERNEL_2_6_$(ver)=y))
KERNEL_SUBLEVEL := -1
endif

COMPAT_VERSIONS := $(shell I=$(COMPAT_LATEST_VERSION); while [ "$$I" -gt $(KERNEL_SUBLEVEL) ]; do echo $$I; I=$$(($$I - 1)); done)
$(foreach ver,$(COMPAT_VERSIONS),$(eval CONFIG_COMPAT_KERNEL_3_$(ver)=y))

ifdef CONFIG_COMPAT_KERNEL_2_6_24
$(error "ERROR: compat-wireless by default supports kernels >= 2.6.24, try enabling only one driver though")
endif #CONFIG_COMPAT_KERNEL_2_6_24

ifeq ($(CONFIG_CFG80211),y)
$(error "ERROR: your kernel has CONFIG_CFG80211=y, you should have it CONFIG_CFG80211=m if you want to use this thing.")
endif


# 2.6.27 has FTRACE_DYNAMIC borked, so we will complain if
# you have it enabled, otherwise you will very likely run into
# a kernel panic.
ifeq ($(shell test $(KERNEL_VERSION) -eq 2 -a $(KERNEL_SUBLEVEL) -eq 27 && echo yes),yes)
ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
$(error "ERROR: Your 2.6.27 kernel has CONFIG_DYNAMIC_FTRACE, please upgrade your distribution kernel as newer ones should not have this enabled (and if so report a bug) or remove this warning if you know what you are doing")
endif
endif

# This is because with CONFIG_MAC80211 include/linux/skbuff.h will
# enable on 2.6.27 a new attribute:
#
# skb->do_not_encrypt
#
# and on 2.6.28 another new attribute:
#
# skb->requeue
#
# In kernel 2.6.32 both attributes were removed.
#
ifeq ($(shell test $(KERNEL_VERSION) -eq 2 -a $(KERNEL_SUBLEVEL) -ge 27 -a $(KERNEL_SUBLEVEL) -le 31 && echo yes),yes)
ifeq ($(CONFIG_MAC80211),)
$(error "ERROR: Your >=2.6.27 and <= 2.6.31 kernel has CONFIG_MAC80211 disabled, you should have it CONFIG_MAC80211=m if you want to use this thing.")
endif
endif

ifneq ($(KERNELRELEASE),) # This prevents a warning

# We will warn when you don't have MQ support or NET_SCHED enabled.
#
# We could consider just quiting if MQ and NET_SCHED is disabled
# as I suspect all users of this package want 802.11e (WME) and
# 802.11n (HT) support.
ifeq ($(CONFIG_NET_SCHED),)
 QOS_REQS_MISSING+=CONFIG_NET_SCHED
endif

ifneq ($(QOS_REQS_MISSING),) # Complain about our missing dependencies
$(warning "WARNING: You are running a kernel >= 2.6.23, you should enable in it $(QOS_REQS_MISSING) for 802.11[ne] support")
endif

endif # build check
endif # kernel Makefile check

# These both are needed by compat-wireless || compat-bluetooth so enable them
 CONFIG_COMPAT_RFKILL=y

ifeq ($(CONFIG_MAC80211),y)
$(error "ERROR: you have MAC80211 compiled into the kernel, CONFIG_MAC80211=y, as such you cannot replace its mac80211 driver. You need this set to CONFIG_MAC80211=m. If you are using Fedora upgrade your kernel as later version should this set as modular. For further information on Fedora see https://bugzilla.redhat.com/show_bug.cgi?id=470143. If you are using your own kernel recompile it and make mac80211 modular")
else
 CONFIG_COMPAT_WIRELESS=y
 CONFIG_COMPAT_WIRELESS_MODULES=m
 CONFIG_COMPAT_VAR_MODULES=m
# We could technically separate these but not yet, we only have b44
# Note that we don't intend on backporting network drivers that
# use Multiqueue as that was a pain to backport to kernels older than
# 2.6.27. But -- we could just disable those drivers from kernels
# older than 2.6.27
 CONFIG_COMPAT_NETWORK_MODULES=m
 CONFIG_COMPAT_NET_USB_MODULES=m
endif

# The Bluetooth compatibility only builds on kernels >= 2.6.27 for now
ifndef CONFIG_COMPAT_KERNEL_2_6_27
ifeq ($(CONFIG_BT),y)
# we'll ignore compiling bluetooth
else
 CONFIG_COMPAT_BLUETOOTH=y
 CONFIG_COMPAT_BLUETOOTH_MODULES=m
endif
endif #CONFIG_COMPAT_KERNEL_2_6_27

ifdef CONFIG_COMPAT_KERNEL_2_6_33
ifdef CONFIG_FW_LOADER
 CONFIG_COMPAT_FIRMWARE_CLASS=m
endif #CONFIG_FW_LOADER
endif #CONFIG_COMPAT_KERNEL_2_6_33

CONFIG_BT=m
CONFIG_COMPAT_BT_L2CAP=y
CONFIG_COMPAT_BT_SCO=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_CMTP depends on ISDN_CAPI
ifdef CONFIG_ISDN_CAPI
CONFIG_BT_CMTP=m
endif #CONFIG_ISDN_CAPI
ifndef CONFIG_COMPAT_KERNEL_2_6_28
CONFIG_COMPAT_BT_HIDP=m
endif #CONFIG_COMPAT_KERNEL_2_6_28

CONFIG_BT_HCIUART=M
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y

CONFIG_BT_HCIVHCI=m
