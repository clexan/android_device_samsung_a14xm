#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a14xm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := a14xm
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 450

# HIDL
ODM_MANIFEST_SKUS += dsds qsqs tsts ss
ODM_MANIFEST_DSDS_FILES := $(DEVICE_PATH)/configs/sku/manifest_dsds.xml
ODM_MANIFEST_QSQS_FILES := $(DEVICE_PATH)/configs/sku/manifest_qsqs.xml
ODM_MANIFEST_TSTS_FILES := $(DEVICE_PATH)/configs/sku/manifest_tsts.xml
ODM_MANIFEST_SS_FILES := $(DEVICE_PATH)/configs/sku/manifest_ss.xml




# Kernel
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 loop.max_part=7
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x11088000
BOARD_KERNEL_TAGS_OFFSET := 0x07c08000
BOARD_DTB_OFFSET := 0x07c08000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_KERNEL_CONFIG := a14xm_defconfig
TARGET_KERNEL_SOURCE := kernel/samsung/a14xm

# Temporary stock prebuilts for initial userspace bring-up. Keep recovery
# buildable so Lineage recovery remains available for installation and logs.
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
BOARD_PREBUILT_BOOTIMAGE := $(DEVICE_PATH)/prebuilts/boot.img
BOARD_PREBUILT_INIT_BOOT_IMAGE := $(DEVICE_PATH)/prebuilts/init_boot.img
BOARD_PREBUILT_VENDOR_BOOTIMAGE := $(DEVICE_PATH)/prebuilts/vendor_boot.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilts/dtb
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 41943040
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 209715200
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_USERDATAIMAGE_PARTITION_SIZE := 116966555648
BOARD_USES_METADATA_PARTITION := true
BOARD_SUPER_PARTITION_SIZE := 9017753600
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
AB_OTA_UPDATER := false
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor_dlkm \
    product \
    odm_dlkm \
    system_dlkm \
    system_ext \
    odm \
    vendor
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 9013559296

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
TARGET_BOARD_PLATFORM := mt6833

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT :=
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.mt6833
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_RECOVERY_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/recovery_dtbo.img
BOARD_RECOVERY_MKBOOTIMG_ARGS := --header_version 2
BOARD_RECOVERY_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_RECOVERY_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_RECOVERY_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
BOOT_SECURITY_PATCH := 2026-07-05
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Verified Boot
BOARD_AVB_ENABLE := true

# Samsung Lineage devices keep structurally valid AVB metadata signed with the
# build system's default development key, while disabling enforcement in the
# top-level vbmeta. Do not set BOARD_AVB_KEY_PATH or BOARD_AVB_ALGORITHM here:
# AOSP defaults them to its RSA-4096 test key and SHA256_RSA4096.
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# A dedicated recovery on a non-A/B device is verified independently and must
# retain its own footer/key configuration even when top-level AVB is disabled.
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := \
    system \
    system_ext \
    system_dlkm \
    product \
    vendor \
    vendor_dlkm \
    odm \
    odm_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# SEPolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# USB Gadget: Disable generic hardware/mediatek init.mediatek.usb.rc in favor of device-specific Samsung script
$(call soong_config_set_bool,mediatek_gadget,use_custom_usb_gadget_rc,true)

# Wi-Fi
# Stock uses the MediaTek cfg80211 driver (wlan_drv_gen4m_6833), so the
# standard NL80211 backend is required for both hostapd and wpa_supplicant.
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211

# MediaTek combo-connectivity driver control device, present on stock.
WIFI_DRIVER_FW_PATH_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA := "STA"
WIFI_DRIVER_FW_PATH_AP := "AP"
WIFI_DRIVER_FW_PATH_P2P := "P2P"
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_STATE_ON := "1"
WIFI_DRIVER_STATE_OFF := "0"

# Verified against the stock Wi-Fi service: STA+STA, STA+P2P, and STA+NAN
# are supported. SoftAP is supported by itself, but starting it replaces STA;
# AP bridging is unsupported.
WIFI_HAL_INTERFACE_COMBINATIONS := {{{STA}, 2}}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{AP}, 1}}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{STA}, 1}, {{P2P}, 1}}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{STA}, 1}, {{NAN}, 1}}

# Include the AIDL supplicant service init entry used by stock.
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Inherit the proprietary files
include vendor/samsung/a14xm/BoardConfigVendor.mk
