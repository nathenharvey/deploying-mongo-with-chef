#
# Cookbook Name:: mongodb
# Recipe:: 10gen_repo
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

# set the initialization style
init = "debian-sysvinit"
case node["init_style"]
when "sysvinit"
  init = "debian-sysvinit"
when "upstart"
  init = "ubuntu-upstart"
end

case node["platform"]
when "debian", "ubuntu"
  include_recipe "apt"

  execute "apt-get update" do
    action :nothing
  end

  apt_repository "10gen" do
    keyserver "keyserver.ubuntu.com"
    key "7F0CEB10"
    uri "http://downloads-distro.mongodb.org/repo/#{init}"
    distribution "dist"
    components ["10gen"]
    action :add
    notifies :run, "execute[apt-get update]", :immediately
  end
when "centos", "redhat", "fedora", "amazon", "scientific"
  include_recipe "yum"

  execute "yum clean all" do
    action :nothing
  end

  yum_repository "10gen" do
    description "10gen RPM Repository"
    url "http://downloads-distro.mongodb.org/repo/redhat/os/$basearch"
    action :add
    notifies :run, "execute[yum clean all]", :immediately
  end
end
