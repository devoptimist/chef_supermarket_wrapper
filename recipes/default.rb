#
# Cookbook:: chef_supermarket_wrapper
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
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

include_recipe 'supermarket-omnibus-cookbook'
