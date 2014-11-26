#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "httpd" do
  action :install
end

service "httpd" do
  action [:enable,:start] #enable:os起動時に立ち上がる,start:走査時起動
  supports :status=>true,:restart=>true,:reload=>true #他のリソースなどに「status,restart,reloadが使えるよ」と教えるためのオプション。restartを書かないとstop+startで代用される。
end

template "/etc/httpd/conf/httpd.conf" do
  owner "apache"
  group "apache"
  notifies :reload,'service[httpd]'
end

