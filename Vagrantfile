Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu64-ruby-1.9.3"
  config.vm.customize do |vm|
    vm.memory_size = 256
  end
  config.vm.forward_port(22, 2717, :auto => true)
  config.ssh.timeout = 300
  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = "https://api.opscode.com/organizations/mdc"
    chef.validation_key_path = "../.chef/ci-validator.pem"
    chef.environment = "vagrant_development"
    chef.validation_client_name = "ci-validator"
    chef.add_recipe("magic_shell")
    chef.node_name = "mongo01"
  end
end
