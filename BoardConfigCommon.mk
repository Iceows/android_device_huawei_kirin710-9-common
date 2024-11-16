#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/huawei/kirin710-9-common

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53



# Bluetooth
BOARD_USES_LIBBT_WRAPPER := true

# Build System
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Filesystems
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
#BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

# Huawei use legacy compression and lz4 algo
BOARD_EROFS_USE_LEGACY_COMPRESSION := true
BOARD_VENDORIMAGE_EROFS_COMPRESSOR := lz4
BOARD_ODMIMAGE_EROFS_COMPRESSOR := lz4
BOARD_SYSTEMIMAGE_EROFS_COMPRESSOR := lz4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Init
TARGET_INIT_VENDOR_LIB := //hardware/hisi:init_hisi
TARGET_RECOVERY_DEVICE_MODULES := init_hisi

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

TARGET_KERNEL_CONFIG := hisi3660_defconfig
TARGET_KERNEL_SOURCE := kernel/huawei/hi3660

#TARGET_KERNEL_CLANG_VERSION := r416183b
#TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/kernel/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
#TARGET_KERNEL_LLVM_BINUTILS := false
#TARGET_KERNEL_ADDITIONAL_FLAGS := HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11"

#-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11

# BootIMG
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_HAS_RAMDISK := false
BOARD_CUSTOM_BOOTIMG_MK := $(COMMON_PATH)/tools/mkbootimg.mk

# Kernel prebuild by GCC
BOARD_KERNEL_BASE := 0x00478000
BOARD_KERNEL_CMDLINE := loglevel=4 coherent_pool=512K page_tracker=on slub_min_objects=12 unmovable_isolate1=2:192M,3:224M,4:256M printktimer=0xfff0a000,0x534,0x538 androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --tags_offset 0x07A00000 --kernel_offset 0x00080000 --ramdisk_offset 0x07c00000 --header_version 1 --os_version 9 --os_patch_level 2019-05-05
BOARD_KERNEL_IMAGE_NAME := Image.gz

TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(COMMON_PATH)/kernel/Image.gz
endif

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM := system
#TARGET_COPY_OUT_PRODUCT := product

ifneq ($(WITH_GMS),true)
#BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
#BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 94371840
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 94371840
endif

BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 94371840
BOARD_ODMIMAGE_PARTITION_RESERVED_SIZE := 94371840

# Platform and board
TARGET_SOC := kirin710
TARGET_BOARD_PLATFORM := kirin710


# Properties
TARGET_VENDOR_PROP += $(COMMON_PATH)/properties/vendor.prop

# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE := true
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/configs/fstab/fstab.recovery
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/tools/

# RIL
BOARD_PROVIDES_LIBRIL := true
BOARD_USES_LIBRIL_WRAPPER := true
ENABLE_VENDOR_RIL_SERVICE := true

# Root
BOARD_ROOT_EXTRA_FOLDERS += \
    3rdmodem \
    3rdmodemnvm \
    3rdmodemnvmbkp \
    modem_log \
    sec_storage \
    metadata \
    splash2

# SELinux
include device/hisi/sepolicy/SEPolicy.mk

# SPL
VENDOR_SECURITY_PATCH := 2019-05-05 # ANE-LGRP2-OVS 9.1.0.401

# HIDL
DEVICE_MATRIX_FILE += $(COMMON_PATH)/hidl/compatibility_matrix.xml
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/hidl/manifest.xml

# VNDK
PRODUCT_USE_VNDK_OVERRIDE := true

# Wifi
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Inherit the proprietary files
include vendor/huawei/kirin710-9-common/BoardConfigVendor.mk
