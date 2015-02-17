#!/system/bin/sh

PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
ORIG_NVS_BIN=/system/etc/firmware/ti-connectivity/wl1271-nvs_127x.bin
INI_FILE=/system/etc/firmware/ti-connectivity/ini_files/TQS_S_2.6.ini
NVS_BIN=/system/etc/firmware/ti-connectivity/wl1271-nvs.bin
WLAN_MODULE=/system/lib/modules/wl12xx_sdio.ko

if [ ! -f "$NVS_BIN" ]; then
    # be sure this wasn't run manually with the module loaded
    rmmod wl12xx_sdio
    mount -o remount,rw /system
    MAC=`cat /rom/devconf/MACAddress | sed 's/\(..\)\(..\)\(..\)\(..\)\(..\)/\1:\2:\3:\4:\5:/'`
    calibrator plt autocalibrate wlan0 $WLAN_MODULE $INI_FILE $NVS_BIN $MAC
    chmod 644 ${NVS_BIN}
    mount -o remount,ro /system
fi

insmod /system/lib/modules/wl12xx_sdio.ko
