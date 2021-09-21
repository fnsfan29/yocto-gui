#!/bin/bash

# ssh
mkdir ~/.ssh
sudo cp /vagrant_data/id_rsa ~/.ssh/
sudo chmod 777 ~/.ssh/id_rsa
echo "StrictHostKeyChecking=no" > ~/.ssh/config

# swap
sudo dd if=/dev/zero of=/swapfile bs=1GB count=8
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
ls -l /etc/fstab
sudo bash -c " echo '/swapfile none swap defaults 0 0' >> /etc/fstab"

# Prepare Yocto environment.
sudo apt-get update
sudo apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping libsdl1.2-dev xterm

# Prepare userspace environment.
# @HACK: qtwebengine error
sudo apt-get install -y g++-multilib genromfs zip

# yocto source code 
mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo-1 > ~/bin/repo
chmod a+x ~/bin/repo
mkdir imx-yocto-bsp
cd imx-yocto-bsp
~/bin/repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-sumo -m imx-4.14.98-2.0.0_ga.xml
~/bin/repo sync

