#
# Cookbook Name:: mysql
# Resource:: app
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

actions :create

attribute :database, :kind_of => String, :name_attribute => true
attribute :username, :kind_of => String, :default => nil
attribute :password, :kind_of => String, :default => nil
attribute :host, :kind_of => String, :default => "%"
attribute :privileges, :kind_of => Array, :default => [:all]

attribute :connection, :kind_of => Hash, :default => {
  "host" => "localhost",
  "port" => 3306,
  "username" => node["mysql"]["credentials"]["username"],
  "password" => node["mysql"]["credentials"]["password"]
}

default_action :create
