# Samsung Galaxy Core Prime LTE (SM-G360F, rossa) — LineageOS 14.1

Device tree for the SM-G360F, built on Galaxy-MSM8916's cm-14.1 trees:

    device/samsung/rossa                 (this tree: variant config only)
      -> device/samsung/coreprimelte-common
         -> device/samsung/msm8916-common
    vendor/samsung/rossa                 (G360F-specific blobs, 68 files)
    vendor/samsung/{msm8916-common,coreprimelte-common}
    kernel/samsung/msm8916               (+ patches/kernel, see below)

## Local manifest

Sync `https://github.com/LineageOS/android -b cm-14.1`, then add
`.repo/local_manifests/rossa.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote name="galaxy" fetch="https://github.com/Galaxy-MSM8916" revision="cm-14.1" />
  <remote name="nnc" fetch="https://github.com/notnoelchannel2" revision="cm-14.1" />

  <!-- Device -->
  <project path="device/samsung/rossa" name="android_device_samsung_rossa" remote="nnc" />
  <project path="vendor/samsung/rossa" name="android_vendor_samsung_rossa" remote="nnc" />

  <!-- Galaxy-MSM8916 common -->
  <project path="device/samsung/coreprimelte-common" name="android_device_samsung_coreprimelte-common" remote="galaxy" />
  <project path="device/samsung/msm8916-common" name="android_device_samsung_msm8916-common" remote="galaxy" />
  <project path="kernel/samsung/msm8916" name="android_kernel_samsung_msm8916" remote="galaxy" />
  <project path="vendor/samsung" name="proprietary_vendor_samsung" remote="galaxy" />

  <!-- Dependencies of msm8916-common (LineageOS) -->
  <project path="hardware/samsung" name="LineageOS/android_hardware_samsung" />
  <project path="packages/resources/devicesettings" name="LineageOS/android_packages_resources_devicesettings" />
  <project path="device/qcom-common" name="LineageOS/android_device_qcom_common" />
  <project path="device/samsung/qcom-common" name="LineageOS/android_device_samsung_qcom-common" />
  <project path="external/sony/boringssl-compat" name="LineageOS/android_external_sony_boringssl-compat" />
  <project path="external/stlport" name="LineageOS/android_external_stlport" />
  <project path="hardware/qcom/fm" name="LineageOS/android_hardware_qcom_fm" />
</manifest>
```

## Kernel

Galaxy-MSM8916's kernel only has the Sprint/T-Mobile rossa variants. Apply
the SM-G360F variant after syncing:

```sh
cd kernel/samsung/msm8916
git am ../../../device/samsung/rossa/patches/kernel/0001-msm8916-Add-rossa-EUR-SM-G360F-variant.patch
```

It adds `msm8916_sec_rossa_eur_defconfig`, the rossa-eur-r00/r01 DTS and
`MACH_ROSSA_EUR_OPEN`. All drivers it enables already exist in that kernel.

## Build

```sh
. build/envsetup.sh
lunch lineage_rossa-userdebug
mka bacon
```
