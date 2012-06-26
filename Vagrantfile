Vagrant::Config.run do |config|
  config.vm.define :mongo01 do |mongo01|
    # Every Vagrant virtual environment requires a box to build off of.
    mongo01.vm.box = "ubuntu64-ruby-1.9.3"
    mongo01.vm.customize do |vm|
      vm.memory_size = 256
    end
    mongo01.vm.forward_port(22, 2717, :auto => true)
    mongo01.ssh.timeout = 300
    mongo01.vm.network :hostonly, "192.168.1.10"
    mongo01.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://api.opscode.com/organizations/mdc"
      chef.validation_key_path = ".chef/mdc-validator.pem"
      chef.validation_client_name = "mdc-validator"
      chef.add_recipe("mongodb::10gen_repo")
      chef.node_name = "mongo01"
    end
  end

  config.vm.define :mongo02 do |mongo02|
    # Every Vagrant virtual environment requires a box to build off of.
    mongo02.vm.box = "ubuntu64-ruby-1.9.3"
    mongo02.vm.customize do |vm|
      vm.memory_size = 256
    end
    mongo02.vm.forward_port(22, 2719, :auto => true)
    mongo02.ssh.timeout = 300
    mongo02.vm.network :hostonly, "192.168.1.11"
    mongo02.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://api.opscode.com/organizations/mdc"
      chef.validation_key_path = ".chef/mdc-validator.pem"
      chef.validation_client_name = "mdc-validator"
      chef.add_recipe("mongodb::install")
      chef.node_name = "mongo02"
    end
  end

  config.vm.define :arbiter do |arbiter|
    # Every Vagrant virtual environment requires a box to build off of.
    arbiter.vm.box = "ubuntu64-ruby-1.9.3"
    arbiter.vm.customize do |vm|
      vm.memory_size = 256
    end
    arbiter.vm.forward_port(22, 2721, :auto => true)
    arbiter.ssh.timeout = 300
    arbiter.vm.network :hostonly, "192.168.1.13"
    arbiter.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://api.opscode.com/organizations/mdc"
      chef.validation_key_path = ".chef/mdc-validator.pem"
      chef.validation_client_name = "mdc-validator"
      chef.add_recipe("apt")
      chef.node_name = "arbiter"
    end
  end
end
