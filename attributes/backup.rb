#
# Cookbook Name:: mysql
# Attributes:: backup
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

default["mysql"]["backup"]["executable"] = "/usr/local/sbin/mysqlbackup"
default["mysql"]["backup"]["target"] = "/backup/mysql"
default["mysql"]["backup"]["maximum"] = 14
default["mysql"]["backup"]["databases"] = %w()

default["mysql"]["backup"]["cron"]["minute"] = 0
default["mysql"]["backup"]["cron"]["hour"] = 5
default["mysql"]["backup"]["cron"]["day"] = "*"
default["mysql"]["backup"]["cron"]["month"] = "*"
default["mysql"]["backup"]["cron"]["weekday"] = "*"
