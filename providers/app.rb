#
# Cookbook Name:: mysql
# Provider:: app
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

require "chef/dsl/include_recipe"
include Chef::DSL::IncludeRecipe

action :create do
  include_recipe "mysql::client"

  mysql_database_user new_resource.username do
    connection new_resource.connection

    password new_resource.password
    privileges new_resource.privileges
    host new_resource.host

    action :create
  end

  mysql_database new_resource.database do
    connection new_resource.connection
    owner new_resource.username

    action :create
  end

  mysql_database_user new_resource.username do
    connection new_resource.connection

    password new_resource.password
    database_name new_resource.database
    privileges new_resource.privileges
    host new_resource.host

    action :grant
  end

  new_resource.updated_by_last_action(true)
end
