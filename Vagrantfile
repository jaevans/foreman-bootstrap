# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

   config.vm.network "forwarded_port", guest: 443, host: 1443

   config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     #vb.gui = true
  
     # Customize the amount of memory on the VM:
     vb.memory = "3072"
     vb.cpus = 2
     vb.name = 'foreman.vagrant'
   end

   config.vm.hostname = 'foreman.vagrant'
   config.vm.network :private_network, ip: '192.168.32.5'

   config.vm.provision :shell, :path => 'scripts/common.sh'
   config.vm.provision :shell, :path => 'scripts/puppet_setup.sh'
end
