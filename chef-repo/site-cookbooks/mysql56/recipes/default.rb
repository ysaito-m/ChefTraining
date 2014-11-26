#
# Cookbook Name:: mysql56
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# setting files
node['mysql']['files'].each do |file|
  cookbook_file "#{file[:path]}#{file[:file_name]}" do
    source "#{file[:file_name]}"
    mode   00644
    owner  "root"
    group  "root"
  end
end

# install packages
node['mysql']['packages'].each do |mysql|
  package mysql do
    action :install
  end
end
 
# service start
service "mysqld" do
  action :start
end

# setting root password
bash "set_password" do
  user "root"
  not_if "mysql -u root -p#{node[:mysql][:password]} -e 'show databases'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret |awk '{print $(NF - 0)}'`
    mysql -u root -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('#{node[:mysql][:password]}');"
    mysql -u root -p#{node[:mysql][:password]} -e "SET PASSWORD FOR root@'127.0.0.1'=PASSWORD('#{node[:mysql][:password]}');"
    mysql -u root -p#{node[:mysql][:password]} -e "FLUSH PRIVILEGES;"
  EOL
end