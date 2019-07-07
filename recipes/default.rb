#
# Cookbook:: chef_supermarket_wrapper
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

remote_file '/bin/jq' do
  source node['supermarket_wrapper']['jq_url']
  mode '0755'
end

if node['platform_family'] == 'suse'
  platform = 'el'
  platform_version = '7'
end


hostname = if node['supermarket_wrapper']['fqdn'] != ''
              node['supermarket_wrapper']['fqdn']
           elsif node['cloud'] && node['supermarket_wrapper']['cloud_public_address']
              node['cloud']['public_ipv4_addrs'].first
           else
             node['ipaddress']
           end

config = node['supermarket_wrapper']['config'].to_hash

config['fqdn'] = hostname

chef_supermarket 'supermarket' do
  channel node['supermarket_wrapper']['channel'].to_sym
  version node['supermarket_wrapper']['version']
  config config
  chef_server_url node['supermarket_wrapper']['chef_server_url'] if node['supermarket_wrapper']['chef_server_url'] != ''
  chef_oauth2_app_id node['supermarket_wrapper']['chef_oauth2_app_id']
  chef_oauth2_secret node['supermarket_wrapper']['chef_oauth2_secret']
  chef_oauth2_verify_ssl node['supermarket_wrapper']['chef_oauth2_verify_ssl']
  accept_license node['supermarket_wrapper']['accept_license']
  platform platform if platform
  platform_version platform_version if platform_version
end
