#
# Cookbook Name:: mysql
# Attributes:: server
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

case node["platform_family"]
when "debian"
  default["mysql"]["server"]["packages"] = %w(
    mysql-server
  )

  default["mysql"]["server"]["config_file"] = "/etc/mysql/my.cnf"
  default["mysql"]["server"]["config_dir"] = "/etc/mysql/conf.d"

  default["mysql"]["server"]["plugin_files"] = %w(
    mysqld_safe_syslog
  )

  default["mysql"]["server"]["removed_dirs"] = %w(
    /etc/mysql/conf.d
  )
when "ubuntu"
  default["mysql"]["server"]["packages"] = %w(
    mysql-server
  )

  default["mysql"]["server"]["config_file"] = "/etc/mysql/my.cnf"
  default["mysql"]["server"]["config_dir"] = "/etc/mysql/conf.d"

  default["mysql"]["server"]["plugin_files"] = %w(
    mysqld_safe_syslog
  )

  default["mysql"]["server"]["removed_dirs"] = %w(
    /etc/mysql/conf.d
  )
when "suse"
  default["mysql"]["server"]["packages"] = %w(
    mysql
  )

  default["mysql"]["server"]["config_file"] = "/etc/my.cnf"
  default["mysql"]["server"]["config_dir"] = "/etc/mysql"

  default["mysql"]["server"]["plugin_files"] = %w(
    default_plugins
  )

  default["mysql"]["server"]["removed_dirs"] = %w(
    /etc/mysql
  )
end

default["mysql"]["server"]["removed_files"] = %w(
  /etc/mysql/conf.d/.keepme
  /etc/mysql/conf.d/mysqld_safe_syslog.cnf
  /etc/mysql/default_plugins.cnf
)

default["mysql"]["server"]["removed_links"] = %w(

)

default["mysql"]["server"]["service_name"] = "mysql"
default["mysql"]["server"]["listen"] = "127.0.0.1"
default["mysql"]["server"]["port"] = 3306

default["mysql"]["server"]["ssl"]["enabled"] = false
default["mysql"]["server"]["ssl"]["key"] = ""
default["mysql"]["server"]["ssl"]["cert"] = ""
default["mysql"]["server"]["ssl"]["ca"] = ""
