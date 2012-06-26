#
# Cookbook Name:: mongodb
# Recipe:: configure
#
# Copyright 2012, CustomInk, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'mongodb::users'

service node['mongodb']['service_name'] do
  supports [:start, :stop, :restart]
end


template node['mongodb']['configfile'] do
  source "mongodb.conf.erb"
  cookbook "mongodb"
  variables(
    :fqdn => node['fqdn'],
    :dbpath => node['mongodb']['dbpath'],
    :logpath => node['mongodb']['logpath'],
    :port => node['mongodb']['port'],
    :journal => node['mongodb']['journal'],
    :httpinterface => node['mongodb']['nohttpinterface'],
    :rest => node['mongodb']['rest'],
    :replication_set => node['mongodb']['replicaset'],
    :fork => platform?("centos", "redhat", "fedora", "amazon"),
    :quiet => node['mongodb']['quiet']
  )
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, "service[#{node['mongodb']['service_name']}]", :immediately
end


