#
# Copyright (C) 2017 The LineageOS Project
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

# Inherit from common msm8953-common
-include device/xiaomi/msm8953-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/daisy

# Filesystem
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true

BOARD_SUPPRESS_SECURE_ERASE := true

# Kernel
TARGET_KERNEL_CONFIG := daisy-perf_defconfig

# Partitions
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 54819535872
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Root Folders
BOARD_ROOT_EXTRA_FOLDERS := bt_firmware dsp firmware persist

#Storage
BOARD_HAS_REMOVABLE_STORAGE := true
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/touchpanel/enable_dt2w"

# Properties
#TARGET_SYSTEM_PROP := $(DEVICE_PATH)/system.prop
TARGET_PROVIDES_QTI_TELEPHONY_JAR := true

# Sepolicy
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# TWRP Configuration
BOARD_HAS_LARGE_FILESYSTEM := true
#BOARD_HAS_NO_SELECT_BUTTON := true
#TARGET_RECOVERY_WIPE := /home/oreo/los/device/xiaomi/daisy/recovery/root/etc/recovery.wipe
AB_OTA_UPDATER := true
#TW_THEME := portrait_hdpi
#TW_INCLUDE_CRYPTO := true
#TW_MAX_BRIGHTNESS := 101
#TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness
#TW_EXCLUDE_SUPERSU := true
#TW_EXTRA_LANGUAGES := true
#TW_NO_SCREEN_BLANK := true
#TW_INPUT_BLACKLIST := "hbtp_vm"
#TARGET_RECOVERY_QCOM_RTC_FIX := true
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
#RECOVERY_SDCARD_ON_DATA := true
#RECOVERY_GRAPHICS_USE_LINELENGTH := true
#TW_EXCLUDE_DEFAULT_USB_INIT := true

#TARGET_RECOVERY_DEVICE_MODULES += android.hardware.boot@1.0
#TW_RECOVERY_ADDITIONAL_RELINK_FILES := ${OUT}/system/lib64/android.hardware.boot@1.0.so

# Treble
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
PRODUCT_FULL_TREBLE_OVERRIDE := true
PB_OFFICIAL := true

# Security Patch Hack to prevent Anti Rollback
PLATFORM_SECURITY_PATCH := 2018-07-01

# Inherit from the proprietary version
-include vendor/xiaomi/daisy/BoardConfigVendor.mk
