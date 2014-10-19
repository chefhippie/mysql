#
# Cookbook Name:: mysql
# Attributes:: server
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

default["mysql"]["server"]["packages"] = value_for_platform_family(
  "debian" => %w(
    mysql-server
  ),
  "ubuntu" => %w(
    mysql-server
  ),
  "suse" => %w(
    mariadb
    mariadb-tools
  )
)

default["mysql"]["server"]["config_file"] = value_for_platform_family(
  "debian" => "/etc/mysql/my.cnf",
  "ubuntu" => "/etc/mysql/my.cnf",
  "suse" => "/etc/my.cnf"
)

default["mysql"]["server"]["removed_files"] = value_for_platform_family(
  "debian" => %w(
    /etc/mysql/conf.d/.keepme
    /etc/mysql/conf.d/mysqld_safe_syslog.cnf
    /etc/mysql/default_plugins.cnf
  ),
  "ubuntu" => %w(
    /etc/mysql/conf.d/.keepme
    /etc/mysql/conf.d/mysqld_safe_syslog.cnf
    /etc/mysql/default_plugins.cnf
  ),
  "suse" => %w(
    /etc/my.cnf.d/default_plugins.cnf
  )
)

default["mysql"]["server"]["removed_dirs"] = value_for_platform_family(
  "debian" => %w(
    /etc/mysql/conf.d
  ),
  "ubuntu" => %w(
    /etc/mysql/conf.d
  ),
  "suse" => %w(

  )
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
