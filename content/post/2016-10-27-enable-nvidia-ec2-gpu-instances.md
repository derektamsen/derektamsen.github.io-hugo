+++
author = "Derek Tamsen"
comments = true
date = "2016-10-27T00:39:00-07:00"
description = "Recently, I needed to use GPU instances with a custom AMI on EC2. The image I needed to use did not contain the necessary NVIDIA and CUDA modules and instead contained nouveau. This posed a unique situation because normally a reboot is necessary after installing the official module. However, the software I was provisioning the instances with was unable to resume after rebooting. Using this short script I was able to swap the opensource nouveau module for the NVIDIA module without rebooting the instance."
draft = false
tags = ["aws", "ec2", "linux", "centos", "nvidia"]
title = "Enable NVIDIA modules in EC2 GPU Instances without Rebooting"
+++
Recently, I needed to use GPU instances with a custom AMI[^ami] on EC2. The image I needed to use did not contain the necessary NVIDIA and CUDA[^cuda] modules and instead contained nouveau. This posed a unique situation because normally a reboot is necessary after installing the official module. However, the software I was provisioning the instances with was unable to resume after rebooting. Using this short script I was able to swap the opensource [nouveau](https://nouveau.freedesktop.org/wiki/) module for the NVIDIA module without rebooting the instance.

Using the script below and a kernel boot parameter the proper modules will be installed without requiring a reboot. This will work on all AWS GPU instance types including g2.2xlarge, g2.8xlarge, and p2.16xlarge. This script can be run in the [user-data](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-add-user-data) portion of [cloud-init](https://cloudinit.readthedocs.io/en/latest/) during instance spin-up.

_This was written and tested for CentOS 6 but can be adapted to other OSes._

```shell
# install gcc, cpp, kernel-headers
# dkms is also installed to rebuild the modules during kernel upgrades
sudo yum groupinstall -y 'Development tools'
sudo yum install -y kernel-devel-$(uname -r) dkms

# download the nvidia module and extract it
wget --quiet 'http://us.download.nvidia.com/XFree86/Linux-x86_64/367.35/NVIDIA-Linux-x86_64-367.35.run' -O 'NVIDIA-Linux-x86_64-367.35.run'
chmod +x NVIDIA-Linux-x86_64-*.run

# unbind the vtconsole from the nouveau module
sudo sh -c 'echo 0 > /sys/class/vtconsole/vtcon1/bind'

# unload nouveau and the direct rendering modules
sudo rmmod nouveau
sudo rmmod ttm
sudo rmmod drm_kms_helper
sudo rmmod drm

# install the nvidia modules silently
sudo ./NVIDIA-Linux-x86_64-*.run --accept-license \
  --no-questions --ui=none --silent \
  --run-nvidia-xconfig --dkms --disable-nouveau

# rebuild the initramfs so it will include the nvidia modules
sudo dracut -f -v /boot/initramfs-$(uname -r).img $(uname -r)

# load the nvidia and direct rendering modules
sudo modprobe nvidia
sudo modprobe ttm
sudo modprobe drm_kms_helper
sudo modprobe drm

# loop through all the pci devices matching the nvidia vendor and K80 device
# identifier and informs linux to remove them from the system to force them to reset.
sudo sh -c "for DEV in $(lspci -d 10de:118a -mm | cut -d' ' -f1); do \
  echo 1 > \"/sys/bus/pci/devices/0000:${DEV}/remove\"
done"
# tell linux to rescan the pci bus. The cards will be added using the nvida modules
sudo sh -c 'echo 1 > /sys/bus/pci/rescan'

# download and install cuda
wget --quiet 'http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-rhel6-7-5-local-7.5-18.x86_64.rpm' \
  -O 'cuda-repo-rhel6-7-5-local-7.5-18.x86_64.rpm'
sudo rpm -i ./cuda-repo-rhel6-7-5-local-7.5-18.x86_64.rpm
sudo yum clean all
sudo yum install -y cuda
```

The above does the following:

  1. Installs items necessary to build the NVIDIA modules.
  2. Downloads the NVIDIA module.
  3. Unbinds the virtual text console from the loaded nouveau module so it can be unloaded.
  4. Unloads the nouveau and direct rendering manager modules.
  5. Installs/Builds the NVIDIA module and tools.
  6. Rebuilds the kernel boot image with the new modules.
  7. Loads the nvidia module and reloads the direct rendering module. This effectively switches the kernel drm modules to use NVIDIA modules.
  8. Ejects all NVIDIA K80 GPUs by their vendor:model identifier. This is necessary to force the cards to reset as they were initialized with nouveau.
  9. Instruct Linux to rescan the pci bus to initialize the NVIDIA cards with the official module.
  10. Download and install CUDA.

You will also need to edit the `kernel` line in `/boot/grub/grub.conf` and append the following:

```shell
rd.driver.blacklist=nouveau nouveau.modeset=0
```

This will tell the kernel to blacklist or not load the nouveau module at boot time. It will also set the display options to none for the module in KMS[^kms].

[^ec2]: Amazon [Elastic Compute Cloud](https://aws.amazon.com/ec2/)
[^ami]: [Amazon Machine Image](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)
[^cuda]: [NVIDIA's parallel computing platform and programing interface](http://www.nvidia.com/object/cuda_home_new.html)
[^kms]: [Kernel Mode Setting](https://en.wikipedia.org/wiki/Mode_setting)
