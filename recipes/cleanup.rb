#
# Cookbook Name:: mysql
# Recipe:: cleanup
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

credentials = if Chef::Config[:solo] and not node.recipes.include?("chef-solo-search")
  node["mysql"]["credentials"]
else
  search(
    "mysql",
    "id:default"
  ).first.to_hash
end

execute "mysql_password" do
  user "root"
  group "root"

  command "mysqladmin -u #{credentials["username"]} password '#{credentials["password"]}'"

  not_if do
    begin
      require "rubygems"
      Gem.clear_paths
      require "mysql"

      ::Mysql.connect(
        "localhost",
        credentials["username"],
        credentials["password"],
        "mysql",
        node["mysql"]["server"]["port"]
      )
    rescue ::Mysql::Error
      false
    end
  end

  action :run
end

[
  "DELETE FROM user WHERE Host = '#{node["hostname"]}' OR Host = '127.0.0.1' OR Host = '::1' OR User = ''",
  "UPDATE user SET Host = '%'"
].each_with_index do |query, index|
  mysql_database "mysql_#{index}" do
    database_name "mysql"

    connection ({
      "host" => "localhost",
      "username" => credentials["username"],
      "password" => credentials["password"]
    })
  
    sql query
    action :query
  end
end
