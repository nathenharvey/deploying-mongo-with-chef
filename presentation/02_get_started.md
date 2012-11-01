!SLIDE
# chef-repo directory

    chef-repo
    |-- .chef
    |   |-- knife.rb
    |   |-- rubynation-validator.pem
    |   `-- rubynation.pem
    |-- README.md
    |-- Rakefile
    |-- certificates
    |-- config
    |   `-- rake.rb
    |-- cookbooks
    |-- data_bags
    |-- environments
    `-- roles

!SLIDE 
# Provision a server

* knife ec2 server create
* knife rackspace server create
* Vagrant
 
<span style="align:right; position:relative; top:-85px;">[![vagrant](images/vagrant.jpg)](http://vagrantup.com/)</span>

!SLIDE
# Vagrantfile

    @@@ ruby
    Vagrant::Config.run do |config|
      config.vm.define :mongo01 do |mongo01|
        mongo01.vm.provision :chef_client do |chef|
          chef.add_role("mongodc")
          chef.node_name = "mongo01"
        end
      end

      config.vm.define :mongo02 do |mongo02|
        mongo02.vm.provision :chef_client do |chef|
          chef.add_role("mongodc")
          chef.node_name = "mongo02"
        end
      end
    end
