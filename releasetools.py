#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

"""Non-A/B firmware installation hooks for Samsung a14xm OTAs."""

import filecmp
import os
import zipfile

import common


# Image name in target-files RADIO/, followed by its recovery fstab mount point.
# Do not add preloader, lk, efuse, param, EFS/NV, or CSC partitions here.
FIRMWARE = (
    ("dpm_1.img", "/dpm_1"),
    ("gz1.img", "/gz1"),
    ("mcupm_1.img", "/mcupm_1"),
    ("md1img.img", "/md1img"),
    ("pi_img.img", "/pi_img"),
    ("scp1.img", "/scp1"),
    ("spmfw.img", "/spmfw"),
    ("sspm_1.img", "/sspm_1"),
    ("tee1.img", "/tee1"),
    ("tzar.img", "/tzar"),
)

# Modern boot-chain images which AOSP's generic non-A/B OTA path does not
# install. boot.img and recovery.img are handled by non_ab_ota.py itself.
# Keep vbmeta last so all images it describes are written first.
BOOT_IMAGES = (
    ("init_boot.img", "/init_boot"),
    ("vendor_boot.img", "/vendor_boot"),
    ("dtbo.img", "/dtbo"),
    ("vbmeta_system.img", "/vbmeta_system"),
    ("vbmeta.img", "/vbmeta"),
)


def _install_firmware(info, target_tmp, source_tmp=None):
    for image, mount_point in FIRMWARE:
        target = os.path.join(target_tmp, "RADIO", image)
        if not os.path.isfile(target):
            raise RuntimeError(f"Missing required a14xm firmware image: {image}")

        if source_tmp is not None:
            source = os.path.join(source_tmp, "RADIO", image)
            if os.path.isfile(source) and filecmp.cmp(source, target, shallow=False):
                continue

        package_path = f"firmware/{image}"
        common.ZipWrite(
            info.output_zip,
            target,
            package_path,
            compress_type=zipfile.ZIP_STORED,
        )
        info.script.Print(f"Installing {mount_point[1:]} firmware...")
        info.script.WriteRawImage(mount_point, package_path)


def _install_boot_images(info, target_tmp, source_tmp=None):
    for image, mount_point in BOOT_IMAGES:
        target = os.path.join(target_tmp, "IMAGES", image)
        if not os.path.isfile(target):
            raise RuntimeError(f"Missing required a14xm boot image: {image}")

        if source_tmp is not None:
            source = os.path.join(source_tmp, "IMAGES", image)
            if os.path.isfile(source) and filecmp.cmp(source, target, shallow=False):
                continue

        package_path = f"images/{image}"
        common.ZipWrite(
            info.output_zip,
            target,
            package_path,
            compress_type=zipfile.ZIP_STORED,
        )
        info.script.Print(f"Installing {mount_point[1:]} image...")
        info.script.WriteRawImage(mount_point, package_path)


def FullOTA_InstallEnd(info):
    _install_firmware(info, info.input_tmp)
    _install_boot_images(info, info.input_tmp)


def IncrementalOTA_InstallEnd(info):
    _install_firmware(info, info.target_tmp, info.source_tmp)
    _install_boot_images(info, info.target_tmp, info.source_tmp)
