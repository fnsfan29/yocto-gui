# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #config.vm.box = "bento/ubuntu-18.04"
  config.vm.box = "ubuntu/bionic64"	
  config.disksize.size = '300GB'
  config.vm.box_check_update = false
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 22, host: 12222, id: "ssh"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL

    sudo apt-get -y update
    sudo apt-get -y upgrade

    # utuntu gui
    sudo apt-get -y install ubuntu-desktop

    # Prepare Yocto environment.
    sudo apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping libsdl1.2-dev xterm

    # ERROR: The following required tools
    sudo apt -y install liblz4-tool zstd
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    # Yocto build
    # Gatesgarth(Yocto 3.2)
    git clone git://git.yoctoproject.org/poky
    cd poky
    git checkout -b gatesgarth

    # build
    source oe-init-build-env
    bitbake core-image-weston

  SHELL

end

