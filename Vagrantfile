# -*- mode: ruby -*-
# vi: set ft=ruby et st=2 sw=2 si ai :

require 'json'

ConfigFileName = '.bootstrap-foreman.json'
DefaultRepo = 'https://github.com/jaevans/foreman-bootstrap.git'

# From http://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable?(exe) && !File.directory?(exe)
    }
  end
  return nil
end

def get_default_repo
  if !which('git').nil? then
    repo = %x[git remote get-url origin].chomp
	if repo.include? '@' then
		repo = 'ssh://' + repo
	end
	repo
  else
    DefaultRepo
  end
end

default_options = {
  "control_repo" => get_default_repo,
  "vm_memory" => "3072",
  "vm_cpus" => 2
}


if File.exist? ConfigFileName then
  options = JSON.parse(File.read(ConfigFileName))
else
  options = default_options
end
puts options

begin
  if ENV['control_repo'] then
    options['control_repo'] = ENV['control_repo']
  end
end
puts options
File.write(ConfigFileName, JSON.pretty_generate(options) + "\n")

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.define "bootstrap-foreman" do |foreman|
    foreman.vm.network "forwarded_port", guest: 443, host: 1443

    foreman.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      #vb.gui = true
    
      # Customize the amount of memory on the VM:
      vb.memory = options['vm_memory']
      vb.cpus = options['vm_cpus'].to_i
      vb.name = 'foreman.vagrant'
    end

    config.vm.provider "libvirt" do |lv|
      lv.memory = 3072
      lv.cpus = 2
    end


    foreman.vm.hostname = 'foreman.vagrant'
    foreman.vm.network :private_network, ip: '192.168.32.5'

    foreman.vm.provision :shell, :path => 'scripts/common.sh'
    foreman.vm.provision :shell, :path => 'scripts/foreman_setup.sh', :args=> [options['control_repo']]
  end
end
