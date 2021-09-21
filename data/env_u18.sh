#!/bin/bash

# @HACK: error /dev/sda3
#vagrant@vagrant:~$ sudo pvcreate /dev/sda3
#  Device /dev/sda3 not found (or ignored by filtering).

sudo fdisk /dev/sda <<EOF
n
p
2


t
2
8e
w
EOF
sudo partprobe
sudo pvcreate /dev/sda2
sudo vgextend vagrant-vg /dev/sda2
sudo lvextend -l +100%FREE /dev/mapper/vagrant--vg-root
sudo resize2fs /dev/mapper/vagrant--vg-root
sudo df -h
sudo fdisk -l
