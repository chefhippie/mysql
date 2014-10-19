#
# Cookbook Name:: mysql
# Recipe:: cleanup
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
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

include_recipe "database"
include_recipe "mysql::credentials"

execute "mysql_password" do
  user "root"
  group "root"

  command "mysqladmin -u #{node["mysql"]["credentials"]["username"]} password '#{node["mysql"]["credentials"]["password"]}'"

  not_if do
    begin
      require "rubygems"
      Gem.clear_paths
      require "mysql"

      ::Mysql.connect(
        node["mysql"]["credentials"]["host"],
        node["mysql"]["credentials"]["username"],
        node["mysql"]["credentials"]["password"],
        "mysql",
        node["mysql"]["credentials"]["port"]
      )
    rescue ::Mysql::Error
      false
    end
  end

  action :run
end

[
  "DELETE FROM user WHERE Host = '#{node["fqdn"].split(".").first}' OR Host = '127.0.0.1' OR Host = '::1' OR User = ''",
  "UPDATE user SET Host = '%' WHERE User = 'root'"
].each_with_index do |query, index|
  mysql_database "mysql_#{index}" do
    database_name "mysql"

    connection ({
      "host" => node["mysql"]["credentials"]["host"],
      "username" => node["mysql"]["credentials"]["username"],
      "password" => node["mysql"]["credentials"]["password"],
      "port" => node["mysql"]["credentials"]["port"]
    })
  
    sql query
    action :query
  end
end
