#
# Cookbook Name:: mysql
# Recipe:: server
#
# Copyright 2013, Thomas Boerger
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

include_recipe "mysql::credentials"
include_recipe "mysql::client"

node["mysql"]["server"]["packages"].each do |name|
  package name do
    action :install
  end
end

node["mysql"]["server"]["removed_files"].each do |name|
  file name do
    action :delete

    only_if do
      File.exists? name
    end
  end
end

node["mysql"]["server"]["removed_links"].each do |name|
  link name do
    action :delete

    only_if do
      File.symlink? name
    end
  end
end

node["mysql"]["server"]["removed_dirs"].each do |name|
  directory name do
    action :delete
    recursive true

    only_if do
      File.directory? name
    end
  end
end

template node["mysql"]["server"]["config_file"] do
  source "my.cnf.erb"
  owner "root"
  group "root"
  mode 0640

  variables(
    node["mysql"]["server"]
  )

  notifies :restart, "service[mysql]"
end

service "mysql" do
  service_name node["mysql"]["server"]["service_name"]
  action [:enable, :start]
end

include_recipe "mysql::cleanup"
