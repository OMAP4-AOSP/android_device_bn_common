#!/system/bin/sh

PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
ORIG_NVS_BIN=/system/etc/firmware/ti-connectivity/wl1271-nvs_127x.bin
INI_FILE=/system/etc/firmware/ti-connectivity/ini_files/TQS_S_2.6.ini
NVS_BIN=/rom/devconf/wl1271-nvs.bin; MACFILE=/rom/devconf/MACAddress
WLAN_MODULE=wl12xx_sdio; WLAN_PATH=/system/lib/modules/${WLAN_MODULE}.ko

if [ ! -f "$NVS_BIN" ]; then
    # be sure this wasn't run manually with the module loaded
    rmmod $WLAN_MODULE
    MAC=`cat $MACFILE | sed 's/\(..\)\(..\)\(..\)\(..\)\(..\)/\1:\2:\3:\4:\5:/'`
    calibrator plt autocalibrate wlan0 $WLAN_PATH $INI_FILE $NVS_BIN $MAC
    chmod 644 ${NVS_BIN}
fi

insmod $WLAN_PATH
