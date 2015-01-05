#
# Cookbook Name:: locale
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?("ubuntu",  "debian")
  package "locales" do
    action :install
  end

  execute "Update locale" do
    command_string = "update-locale LANG=#{node[:locale][:lang]}"
    command_string << " LANGUAGE=#{node[:locale][:language]}" unless node[:locale][:language].nil?
    command_string << " LC_ALL=#{node[:locale][:lc_all]}" unless node[:locale][:lc_all].nil?
    Chef::Log.debug("locale command is #{command_string.inspect}")
    command command_string
  end
end

if platform?("redhat",  "centos",  "fedora")
  execute "Update locale" do
    command "locale -a | grep ^#{node[:locale][:lang]}$ && sed -i 's|LANG=.*|LANG=#{node[:locale][:lang]}|' /etc/sysconfig/i18n"
  end
end
