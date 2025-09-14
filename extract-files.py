#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/a14xm',
    'hardware/mediatek/libmtkperf_client',
    'hardware/mediatek',
    'hardware/samsung',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}-{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'libuuid': lib_fixup_vendor_suffix,
}

blob_fixups: blob_fixups_user_type = {

    ('vendor/bin/mnld', 'vendor/lib64/libaalservice.so'): blob_fixup()
        .replace_needed('android.hardware.sensors-V2-ndk.so', 'android.hardware.sensors-V3-ndk.so'),
        
    ('vendor/lib64/libmtkcam_hal_aidl_common.so', 'vendor/lib64/libmtkcam_hal_aidl2legacy_common.so', 'vendor/lib64/libcam.utils.sensorprovider.so'): blob_fixup()
        .replace_needed('android.hardware.camera.common-V2-ndk.so', 'android.hardware.camera.common-V1-ndk.so')
        .replace_needed('android.hardware.sensors-V2-ndk.so', 'android.hardware.sensors-V3-ndk.so'),
        
    ('vendor/bin/hw/android.hardware.graphics.allocator-V2-service-mediatek', 'vendor/lib64/vendor.mediatek.hardware.camera.isphal-V1-ndk.so', 'vendor/lib64/libmtkcam_grallocutils.so', 'vendor/lib64/libaimemc.so', 'vendor/lib64/vendor.mediatek.hardware.pq_aidl-V4-ndk.so', 'vendor/lib64/vendor.mediatek.hardware.pq_aidl-V2-ndk.so', 'vendor/lib64/libgpud.so','vendor/lib64/libcodec2_fsr.so', 'vendor/lib64/hw/mapper.mediatek.so', 'vendor/lib64/hw/android.hardware.graphics.allocator-V2-mediatek.so', 'vendor/lib64/egl/libGLES_mali.so', 'vendor/lib64/vendor.mediatek.hardware.pq_aidl-V7-ndk.so'): blob_fixup()
        .replace_needed('android.hardware.graphics.common-V4-ndk.so', 'android.hardware.graphics.common-V6-ndk.so')
        .replace_needed('android.hardware.graphics.common-V5-ndk.so', 'android.hardware.graphics.common-V6-ndk.so'),
        
    ('vendor/lib64/libneuralnetworks_sl_driver_mtk_legacy_prebuilt.so'): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_createFromHandle')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_getNativeHandle')
        .clear_symbol_version('AHardwareBuffer_lock')
        .clear_symbol_version('AHardwareBuffer_lockPlanes')
        .clear_symbol_version('AHardwareBuffer_release')
        .clear_symbol_version('AHardwareBuffer_unlock'),

    ('vendor/lib64/libnvram.so', 'vendor/lib64/libsysenv.so'): blob_fixup()
        .add_needed('libbase_shim.so'),

    'vendor/bin/hw/android.hardware.media.c2-mediatek-64b': blob_fixup()
        .add_needed('libstagefright_foundation-v33.so')
        .replace_needed('libavservices_minijail_vendor.so', 'libavservices_minijail.so'),
    
    'vendor/etc/init/android.hardware.media.c2-mediatek.rc': blob_fixup()
        .regex_replace(r'(/vendor/bin/hw/android\.hardware\.media\.c2-mediatek)\b',
        r'\1-64b'),

}  # fmt: skip

module = ExtractUtilsModule(
    'a14xm',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

module.add_proprietary_file('proprietary-files-camera.txt')

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
