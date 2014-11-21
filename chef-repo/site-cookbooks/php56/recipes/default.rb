#
# Cookbook Name:: php56
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "php" do
  action :install
  options "--enablerepo=remi --enablerepo=remi-php56"
  notifies :reload,'service[httpd]'
end
