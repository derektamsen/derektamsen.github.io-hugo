---
title: "Updating Thinkpad Firmware with Linux"
date: "2017-10-15T16:43:00-07:00"
draft: false
summary: "Lenovo packages its UEFI firmware updater as either a Windows installable package or a bootable CD image. The bootable image is great for those running Linux on their systems. However, if you do not have an external CD drive or do not want to burn a CD, the update process takes a few more steps. Fortunately, the updater can be extracted from the CD image and written to a USB drive with Linux."
description: "Lenovo packages its UEFI firmware updater as either a Windows installable package or a bootable CD image. The bootable image is great for those running Linux on their systems. However, if you do not have an external CD drive or do not want to burn a CD, the update process takes a few more steps. Fortunately, the updater can be extracted from the CD image and written to a USB drive with Linux."
toc: true
readTime: true
autonumber: false
math: false
tags: ["linux", "thinkpad", "firmware"]
showTags: false
hideBackToTop: false
aliases: ["/blog/2017/10/15/updating-thinkpad-firmware-with-linux"]
---

This method should work with most of Lenovo's bootable CD images.

## Prerequisites
To extract the boot image from the ISO you will need to install `genisoimage` which provides the `geteltorito` binary.
```bash
apt-get install genisoimage
```

## Download the Bootable CD Image
- Browse to Lenovo's support page, [support.lenovo.com](https://support.lenovo.com). Then, search the support site for your Thinkpad model.
- Once you have located your model click on the 'Drivers & Software' tab.
- Next, expand the 'BIOS/UEFI' or other firmware download section and download the '...(Bootable CD) for Windows...' file.

## Extracting the Boot Image
Extract the boot image from the firmware update iso:
_Replace `<fwupdate.iso>` with the name of the downloaded iso. Example: n1cuj17w.iso_
```bash
geteltorito '<fwupdate.iso>' > 'fwupdate.img'
```

## Locate the Device Path to your USB Drive
Connect a USB drive for updating your system. **Note: This device will be erased during writing step below!**

Then, tail your system's log to see what device path was assigned to the USB drive:
```bash
sudo tail /var/log/syslog
```

The device name should appear in the output. This is usually `sda` or `sdb`. The path to the device will simply be `/dev/sda` or `/dev/sdb`

## Writing the Boot Image to a USB Drive
Write the extracted boot image to the USB drive. **The device specified as `of=` will be erased!**

_Substitute `<device_path>` with the device path from above._
```bash
sudo dd bs=1M if='fwupdate.img' of='<device_path>'
```

## Update the Firmware
Reboot your system with the USB drive attached. Press `F12` to access your system's boot menu. Then, choose the attached USB drive as the temporary boot device. Next, follow the prompts from the updater utility to update the firmware.
