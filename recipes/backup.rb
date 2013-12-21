#
# Cookbook Name:: mysql
# Recipe:: backup
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

include_recipe "mysql::client"

template node["mysql"]["backup"]["executable"] do
  source "mysqlbackup.erb"

  owner "root"
  group "root"
  mode 0750

  if node["mysql"]["credentials"]["enabled"] 
    variables(
      node["mysql"]["backup"].merge(
        node["mysql"]["credentials"]
      )
    )
  else
    variables(
      node["mysql"]["backup"].merge(
        search(
          "mysql",
          "id:default"
        ).first.to_hash
      )
    )
  end
end

cron "mysqlbackup" do
  minute node["mysql"]["backup"]["cron_minute"]
  hour node["mysql"]["backup"]["cron_hour"]
  day node["mysql"]["backup"]["cron_day"]
  month node["mysql"]["backup"]["cron_month"]
  weekday node["mysql"]["backup"]["cron_weekday"]

  command node["mysql"]["backup"]["executable"]
end
