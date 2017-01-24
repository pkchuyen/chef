#
# Cookbook Name:: demo
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# provision user account
include_recipe 'user::data_bag'

# provision ssh
include_recipe 'openssh'


# --- Install packages we need ---
package [ 'ntp',
          'sysstat',
          'git',
          'screen',
          'python2-pip'] do
  action :install
end

# --- Remove package ---
package [ 'httpd' ] do
  action :remove
end

# --- Add the web app directory ---
%w[ /app /app/public ].each do |path|
  directory path do
    owner 'root'
    group 'root'
    mode '755'
    action :create
  end
end

# --- Set host name ---
hostname = 'app.example.com'

file '/etc/hostname' do
  content "#{hostname}\n"
end

service 'systemd-hostnamed' do
  action :restart
end

file '/etc/hosts' do
  content "127.0.0.1 #{hostname} localhost localhost.localdomain localhost4 localhost4.localdomain4\n"
end


# --- Deploy application ---
git '/app/public' do
  repository 'https://bitbucket.org/granduke/interview_sample_site'
  revision 'master'
  action :sync
  user 'root'
  group 'root'
end

script "Install Requirements" do
  interpreter "bash"
  user "root"
  group "root"
  code <<-EOH
  /bin/pip install -r /app/public/requirements.txt
  EOH
end
