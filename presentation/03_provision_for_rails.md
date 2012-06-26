!SLIDE 
# Deploying MongoDB #

* Install
* Configure
* Run
* Backup
* Monitor

!SLIDE commandline incremental
# Create a Cookbook #

    $ knife cookbook create mongodb
    
    ** Creating cookbook mongodb
    ** Creating README for cookbook: mongodb
    ** Creating metadata for cookbook: mongodb

.notes http://wiki.opscode.com/display/chef/Managing+Cookbooks+With+Knife#ManagingCookbooksWithKnife-create

!SLIDE
# Write our recipes

* 10gen_repo.rb
* install.rb
* configure.rb
* users.rb
* replica_set.rb

!SLIDE
# 10gen Repo Recipe #

    @@@ ruby
    include_recipe "apt"

    execute "apt-get update" do
      action :nothing
    end

    apt_repository "10gen" do
      keyserver "keyserver.ubuntu.com"
      key "7F0CEB10"
      uri "http://downloads-distro.mongodb.org/repo/#{init}"
      action :add
      notifies :run, "execute[apt-get update]", :immediately
    end

!SLIDE
# Install Recipe #

    @@@ ruby
    include_recipe "mongodb::10gen_repo"
    package node['mongodb']['package_name'] do
      version node['mongodb']['version']
      action :install
    end

!SLIDE
# Where does `package_name` come from? #

Attributes defined in the cookbook:
    
    @@@ ruby
    case platform
    when 'debian', 'ubuntu'
      default['mongodb']['package_name'] = 'mongodb-10gen'
    when 'centos', 'redhat', 'fedora', 'amazon', 'scientific'
      default['mongodb']['package_name'] = 'mongo-10gen-server'
    end

!SLIDE
# Configure Recipe #

    @@@ ruby
    template node['mongodb']['configfile'] do
      variables(
        :dbpath => node['mongodb']['dbpath'],
        :logpath => node['mongodb']['logpath'],
        :port => node['mongodb']['port'],
        :journal => node['mongodb']['journal'],
        :replication_set => node['mongodb']['replicaset']
      )
      owner "root"
      group "root"
      mode "0644"
      notifies :restart, "service[#{node['mongodb']['service_name']}]", :immediately
    end

!SLIDE
# Configure Recipe #

The configuration template

    @@@ ruby
    dbpath = <%= @dbpath %>
    logpath = <%= @logpath %>/mongodb.log
    logappend = true
    port = <%= @port %>
    noauth = true

    <% if @journal %>
    journal=true
    <% else -%>
    nojournal=true
    <% end -%>

!SLIDE
# Replication Recipe #

    @@@ ruby
    ruby_block "configure-replica-set" do
    block do
      require "rubygems"
      require "mongo"
          10.times do |try|
      begin
        conn = Mongo::Connection.new(
          "localhost", node['mongodb']['port'],
          :slave_ok => true, :connect_timeout => 5)
      rescue
        delay = 2 ** (try + 1)
        Chef::Log.info("Failed to connect to mongodb, sleeping #{delay}, try #{try}/10")
        sleep(delay)
      end
    end
 


!SLIDE commandline incremental
# Upload cookbooks to Chef server #

    $ knife cookbook upload -a

!SLIDE
# Run chef-client #

* Automatically
* `knife ssh`
* `vagrant provision`

!SLIDE
# Review #

* Servers provisioned and communicating with the Chef API
* MongoDB running in a replica set

