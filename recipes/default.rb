#
# Cookbook:: chef_supermarket_wrapper
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

remote_file '/bin/jq' do
  source node['supermarket_wrapper']['jq_url']
  mode '0755'
end

node.default['supermarket_omnibus']['package_version'] =
  node['supermarket_wrapper']['package_version']

node.default['supermarket_omnibus']['package_repo'] =
  node['supermarket_wrapper']['package_repo']

node.default['supermarket_omnibus']['chef_server_url'] =
  node['supermarket_wrapper']['chef_server_url'] if node['supermarket_wrapper']['chef_server_url'] != ''

node.default['supermarket_omnibus']['chef_oauth2_app_id'] =
  node['supermarket_wrapper']['chef_oauth2_app_id'] if node['supermarket_wrapper']['chef_oauth2_app_id'] != ''

node.default['supermarket_omnibus']['chef_oauth2_secret'] =
  node['supermarket_wrapper']['chef_oauth2_secret'] if node['supermarket_wrapper']['chef_oauth2_secret'] != ''

node.default['supermarket_omnibus']['fqdn'] = if node['supermarket_wrapper']['fqdn'] != ''
                                                node['supermarket_wrapper']['fqdn']
                                              elsif node['cloud']
                                                node['cloud']['public_ipv4_addrs'].first
                                              end

if node['platform_family'] == 'suse'
  node.default['supermarket_omnibus']['package_url'] =
    'https://packages.chef.io/files/stable/supermarket/3.3.3/el/7/supermarket-3.3.3-1.el7.x86_64.rpm'
end

include_recipe 'supermarket-omnibus-cookbook'
