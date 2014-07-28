# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
#  config.vm.provider :virtualbox do |vbox|
#    config.vm.box = "ubuntu:14.04"
#    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
#    config.vm.network "private_network", ip: "192.168.33.10"
#  end

  config.vm.define "docker-host" do |dh|
    dh.vm.provider "docker" do |d|
      d.name="elasticsearch"
      d.build_dir = "elasticsearch/"
      #d.build_image "elasticsearch", args: "-t frosenberg/elasticsearch"
    end

    dh.vm.provider "docker" do |d|
      d.name="kibana2"
      d.build_dir = "kibana/"
      #d.build_image "kibana", args: "-t frosenberg/kibana"
      d.ports  = ['80:8080']
      d.link("elasticsearch:elasticsearch")
    end

#    dh.vm.provider "docker" do |d|
#      d.build_dir = "fluentd/"
#      #d.build_image "fluentd", args: "-t frosenberg/fluentd"
#      d.name="fluentd_agg1"
#      d.link("frosenberg_elasticsearch:elasticsearch")
#    end


  end

end