# -*- mode: ruby -*-
# vi: set ft=ruby et st=2 sw=2 si ai :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.define "bootstrap-foreman" do |foreman|
    foreman.vm.network "forwarded_port", guest: 443, host: 1443

    foreman.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      #vb.gui = true
    
      # Customize the amount of memory on the VM:
      vb.memory = "3072"
      vb.cpus = 2
      vb.name = 'foreman.vagrant'
    end

    config.vm.provider "libvirt" do |lv|
      lv.memory = 3072
      lv.cpus = 2
    end


    foreman.vm.hostname = 'foreman.vagrant'
    foreman.vm.network :private_network, ip: '192.168.32.5'

    foreman.vm.provision :shell, :path => 'scripts/common.sh'
    foreman.vm.provision :shell, :path => 'scripts/foreman_setup.sh'
  end
end
