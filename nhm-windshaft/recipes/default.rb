#
# Cookbook Name:: nhm-windshaft
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "postgres"

package "postgresql-contrib-9.1"
package "postgresql-9.1-postgis"

include_recipe "nodejs::install_from_package"

apt_repository "mapnik" do
  uri "http://ppa.launchpad.net/mapnik/v2.2.0/ubuntu"
  distribution node['lsb']['codename']
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          '5D50B6BA'
end

%w{libmapnik libmapnik-dev mapnik-utils python-mapnik}.each do |p|
  package p
end
