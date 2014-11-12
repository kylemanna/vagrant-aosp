# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Config file stuff stolen from coreos-vagrant
require 'fileutils'

CONFIG = File.join(File.dirname(__FILE__), "config.rb")

# Defaults for config options defined in CONFIG
$vb_gui = false
$vb_memory = 2049
$vb_cpus = 4

if File.exist?(CONFIG)
  require CONFIG
end


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "aosp-dev"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.13.37"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = $vb_gui
    vb.memory = $vb_memory
    vb.cpus = $vb_cpus
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Installs latest version of Docker for us :)
  config.vm.provision "docker" do |d|
    d.pull_images "kylemanna/aosp"
    # d.build_image "/vagrant/docker-aosp"
  end

  config.vm.provision "shell", \
    inline: "curl -s https://raw.githubusercontent.com/kylemanna/docker-aosp/master/utils/aosp -o /usr/local/bin/aosp && chmod 755 /usr/local/bin/aosp"

  # Ansible doesn't add value yet?
  #config.vm.provision "shell", inline: "echo -e '[local]\nlocalhost\n' > /etc/ansible/hosts"
  #config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "playbooks/aosp-dev.yml"
  #end

end
