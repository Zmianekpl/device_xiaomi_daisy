#!/sbin/sh

relink()
{
	fname=$(basename "$1")
	target="/sbin/$fname"
	sed 's|/system/bin/linker64|///////sbin/linker64|' "$1" > "$target"
	chmod 755 $target
}

finish()
{
	umount /v
	umount /s
	rmdir /v
	rmdir /s
	setprop fde.ready 1
	exit 0
}

suffix=$(getprop ro.boot.slot_suffix)
if [ -z "$suffix" ]; then
	suf=$(getprop ro.boot.slot)
	suffix="_$suf"
fi
#venpath="/dev/block/bootdevice/by-name/vendor$suffix"
#mkdir /v
#mount -t ext4 -o ro "$venpath" /v
syspath="/dev/block/bootdevice/by-name/system$suffix"
mkdir /s
mount -t ext4 -o ro "$syspath" /s

#is_fastboot_twrp=$(getprop ro.boot.fastboot)
#if [ ! -z "$is_fastboot_twrp" ]; then
	#osver=$(getprop ro.build.version.release_orig)
	#patchlevel=$(getprop ro.build.version.security_patch_orig)
	#setprop ro.build.version.release "$osver"
	#setprop ro.build.version.security_patch "$patchlevel"
	#finish
#fi

if [ -f /s/system/build.prop ]; then
	# TODO: It may be better to try to read these from the boot image than from /system
	osver=$(grep -i 'ro.build.version.release' /s/system/build.prop  | cut -f2 -d'=')
	patchlevel=$(grep -i 'ro.build.version.security_patch' /s/system/build.prop  | cut -f2 -d'=')
	setprop ro.build.version.release "$osver"
	setprop ro.build.version.security_patch "$patchlevel"
	finish
else
	# Be sure to increase the PLATFORM_VERSION in build/core/version_defaults.mk to override Google's anti-rollback features to something rather insane
	osver=$(getprop ro.build.version.release_orig)
	patchlevel=$(getprop ro.build.version.security_patch_orig)
	setprop ro.build.version.release "$osver"
	setprop ro.build.version.security_patch "$patchlevel"
	finish
fi
finish

mkdir -p /vendor/lib64/hw/

cp /s/system/lib64/android.hardware.boot@1.0-service /sbin/
cp /s/system/lib64/android.hardware.confirmationui@1.0.so /sbin/
cp /s/system/lib64/android.hardware.gatekeeper@1.0-service-qti /sbin/
cp /s/system/lib64/android.hardware.gatekeeper@1.0.so /sbin/
cp /s/system/lib64/android.hardware.keymaster@3.0-service-qti /sbin/
cp /s/system/lib64/android.hardware.keymaster@4.0-service-qti /sbin/
cp /s/system/lib64/android.hidl.base@1.0.so /sbin/
cp /s/system/lib64/bootctrl.msm8953.so /sbin/
cp /s/system/lib64/libGPreqcancel.so /sbin/
cp /s/system/lib64/libGPreqcancel_svc.so /sbin/
cp /s/system/lib64/libQSEEComAPI.so /sbin/
cp /s/system/lib64/libSecureUILib.so /sbin/
cp /s/system/lib64/libStDrvInt.so /sbin/
cp /s/system/lib64/libdiag.so /sbin/
cp /s/system/lib64/libdrmfs.so /sbin/
cp /s/system/lib64/libdrmtime.so /sbin/
cp /s/system/lib64/libicuuc.so /sbin/
cp /s/system/lib64/libkeymaster4support.so /sbin/
cp /s/system/lib64/libkeymaster_messages.so /sbin/
cp /s/system/lib64/libkeymasterdeviceutils.so /sbin/
cp /s/system/lib64/libkeymasterprovision.so /sbin/
cp /s/system/lib64/libkeymasterutils.so /sbin/
cp /s/system/lib64/libqdutils.so /sbin/
cp /s/system/lib64/libqisl.so /sbin/
cp /s/system/lib64/libqservice.so /sbin/
cp /s/system/lib64/libqtikeymaster4.so /sbin/
cp /s/system/lib64/librecovery_updater_msm.so /sbin/
cp /s/system/lib64/librpmb.so /sbin/
cp /s/system/lib64/libsecureui.so /sbin/
cp /s/system/lib64/libsecureui_svcsock.so /sbin/
cp /s/system/lib64/libsecureuisvc_jni.so /sbin/
cp /s/system/lib64/libssd.so /sbin/
cp /s/system/lib64/libtime_genoff.so /sbin/
cp /s/system/lib64/libxml.so /sbin/
cp /s/system/lib64/libxml2.so /sbin/
cp /s/system/lib64/passwd /sbin/
cp /s/system/lib64/prepdecrypt.sh /sbin/
cp /s/system/lib64/qseecomd /sbin/
cp /s/system/lib64/vendor.qti.hardware.qteeconnector@1.0-service /sbin/
cp /s/system/lib64/vendor.qti.hardware.tui_comm@1.0-service-qti /sbin/

relink /v/bin/qseecomd

cp /v/lib64/android.hardware.boot@1.0-service /vendor/lib64/
cp /v/lib64/android.hardware.confirmationui@1.0.so /vendor/lib64/
cp /v/lib64/android.hardware.gatekeeper@1.0-service-qti /vendor/lib64/
cp /v/lib64/android.hardware.gatekeeper@1.0.so /vendor/lib64/
cp /v/lib64/android.hardware.keymaster@3.0-service-qti /vendor/lib64/
cp /v/lib64/android.hardware.keymaster@4.0-service-qti /vendor/lib64/
cp /v/lib64/android.hidl.base@1.0.so /vendor/lib64/
cp /v/lib64/bootctrl.msm8953.so /vendor/lib64/
cp /v/lib64/libGPreqcancel.so /vendor/lib64/
cp /v/lib64/libGPreqcancel_svc.so /vendor/lib64/
cp /v/lib64/libQSEEComAPI.so /vendor/lib64/
cp /v/lib64/libSecureUILib.so /vendor/lib64/
cp /v/lib64/libStDrvInt.so /vendor/lib64/
cp /v/lib64/libdiag.so /vendor/lib64/
cp /v/lib64/libdrmfs.so /vendor/lib64/
cp /v/lib64/libdrmtime.so /vendor/lib64/
cp /v/lib64/libicuuc.so /vendor/lib64/
cp /v/lib64/libkeymaster4support.so /vendor/lib64/
cp /v/lib64/libkeymaster_messages.so /vendor/lib64/
cp /v/lib64/libkeymasterdeviceutils.so /vendor/lib64/
cp /v/lib64/libkeymasterprovision.so /vendor/lib64/
cp /v/lib64/libkeymasterutils.so /vendor/lib64/
cp /v/lib64/libqdutils.so /vendor/lib64/
cp /v/lib64/libqisl.so /vendor/lib64/
cp /v/lib64/libqservice.so /vendor/lib64/
cp /v/lib64/libqtikeymaster4.so /vendor/lib64/
cp /v/lib64/librecovery_updater_msm.so /vendor/lib64/
cp /v/lib64/librpmb.so /vendor/lib64/
cp /v/lib64/libsecureui.so /vendor/lib64/
cp /v/lib64/libsecureui_svcsock.so /vendor/lib64/
cp /v/lib64/libsecureuisvc_jni.so /vendor/lib64/
cp /v/lib64/libssd.so /vendor/lib64/
cp /v/lib64/libtime_genoff.so /vendor/lib64/
cp /v/lib64/libxml.so /vendor/lib64/
cp /v/lib64/libxml2.so /vendor/lib64/
cp /v/lib64/passwd /vendor/lib64/
cp /v/lib64/prepdecrypt.sh /vendor/lib64/
cp /v/lib64/qseecomd /vendor/lib64/
cp /v/lib64/vendor.qti.hardware.qteeconnector@1.0-service /vendor/lib64/
cp /v/lib64/vendor.qti.hardware.tui_comm@1.0-service-qti /vendor/lib64/
cp /v/lib64/vendor.qti.hardware.tui_comm@1.0.so /vendor/lib64/
cp /v/lib64/hw/android.hardware.boot@1.0-impl.so /vendor/lib64/
cp /v/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so /vendor/lib64/
cp /v/lib64/hw/android.hardware.keymaster@3.0-impl-qti.so /vendor/lib64/
cp /v/lib64/hw/android.hardware.keymaster@4.0-impl-qti.so /vendor/lib64/
cp /v/lib64/hw/bootctrl.msm8953.so /vendor/lib64/
cp /v/lib64/hw/gatekeeper.msm8953.so /vendor/lib64/
cp /v/lib64/hw/keystore.msm8953.so /vendor/lib64/

cp /v/manifest.xml /vendor/
cp /v/compatibility_matrix.xml /vendor/
cp /v/etc/vintf/compatibility_matrix.xml /vendor/etc/vintf/
cp /v/etc/vintf/manifest.xml /vendor/etc/vintf/
cp /s/compatibility_matrix.xml /system/
cp /s/etc/vintf/compatibility_matrix.1.xml /system/etc/vintf/
cp /s/etc/vintf/compatibility_matrix.2.xml /system/etc/vintf/
cp /s/etc/vintf/compatibility_matrix.3.xml /system/etc/vintf/
cp /s/etc/vintf/compatibility_matrix.device.xml /system/etc/vintf/
cp /s/etc/vintf/compatibility_matrix.legacy.xml /system/etc/vintf/
cp /s/etc/vintf/manifest.xml /system/etc/vintf/

relink /v/bin/hw/android.hardware.boot@1.0-service
relink /v/bin/hw/android.hardware.keymaster@3.0-service-qti
relink /v/bin/hw/android.hardware.keymaster@4.0-service-qti
relink /v/bin/hw/android.hardware.gatekeeper@1.0-service-qti
relink /v/bin/hw/vendor.qti.hardware.qteeconnector@1.0-service
relink /v/bin/hw/vendor.qti.hardware.tui_comm@1.0-service-qti

finish
exit 0
