# android_device_samsung_heatqlte

## Device tree for Samsung Galaxy Ace Style LTE SM-G357FZ [heatqlte]

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Qualcomm MSM8916 Quad-core 1.2 GHz ARM® Cortex™ A53
CHIPSET | Qualcomm MSM8916 Snapdragon 410
GPU     | Adreno 306
Memory  | 1 GB
Shipped Android Version | 4.4.4
Storage | 8 GB
MicroSD | Up to 64 GB
Battery | 1900 mAh (removable)
Dimensions | 121.2 x 62.7 x 10.7 mm
Display | 480 x 800, 4.0"
Rear Camera  | 5.0 MP, LED flash
Front Camera | 1.3 MP
## cm-13.0 (branch `cm-13.0`)

Based on the cm-12.1 tree, with Marshmallow changes modelled on
Galaxy-MSM8916's gprimeltexx / msm8916-common cm-13.0 trees. Nothing from
cm-12.1 was removed; cm-13.0-only pieces live in:

- `ril13/` — Marshmallow `SamsungQcomRIL` (`BOARD_RIL_CLASS` points here;
  `ril/` keeps the Lollipop class)
- `sepolicy/` — policy from Galaxy-MSM8916 msm8916-common cm-13.0, built on
  device/qcom/sepolicy and vendor/cm/sepolicy (selinux stays permissive on the
  kernel cmdline)
- `patches/frameworks_base/0001-zygote-skip-unsupported-fds.patch` — apply
  to frameworks/base: zygote skips file descriptors it can't classify instead
  of aborting

Extra projects for `.repo/local_manifests` (not in CM 13.0's default manifest):

```xml
<project path="external/stlport" name="LineageOS/android_external_stlport" revision="cm-13.0" />
<project path="external/mm-dash" name="LineageOS/android_external_mm-dash" revision="cm-13.0" />
<project path="hardware/qcom/fm" name="LineageOS/android_hardware_qcom_fm" revision="cm-13.0" />
<project path="device/samsung/qcom-common" name="LineageOS/android_device_samsung_qcom-common" revision="cm-13.0" />
<project path="hardware/samsung" name="LineageOS/android_hardware_samsung" revision="cm-13.0" />
```

Apply the zygote patch after syncing:

```sh
cd frameworks/base
git apply ../../device/samsung/rossa/patches/frameworks_base/0001-zygote-skip-unsupported-fds.patch
```

**Kernel:** Marshmallow's sepolicy needs SELinux policy version 30 (ioctl
command whitelisting). kernel/samsung/coreprimelte (cm-12.1) only supports up
to version 28, so cm-13.0 uses android_kernel_samsung_rossa-2 instead
(3.10.108 plus the Android SELinux xperms backport, branch `selinux-xperms`
until merged):

```xml
<project path="kernel/samsung/rossa" name="notnoelchannel2/android_kernel_samsung_rossa-2" revision="selinux-xperms" />
```

That kernel's `sec_jack` driver reports the headset through
`/sys/class/switch/h2w`, so the cm-13.0 overlay sets
`config_useDevInputEventForAudioJack` to false.
