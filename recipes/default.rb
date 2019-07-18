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

config = node['supermarket_wrapper']['config'].to_hash

hostname = if node['supermarket_wrapper']['fqdn'] != ''
             node['supermarket_wrapper']['fqdn']
           elsif node['cloud'] && node['supermarket_wrapper']['cloud_public_address']
             node['cloud']['public_ipv4_addrs'].first
           else
             node['ipaddress']
           end

config['fqdn'] = hostname

if node['supermarket_wrapper']['cert'] != '' &&
   node['supermarket_wrapper']['cert_key'] != ''

  cert_dir = node['supermarket_wrapper']['cert_directory']
  cert_path = "#{cert_dir}/#{hostname}.crt"
  cert_key_path = "#{cert_dir}/#{hostname}.key"

  directory cert_dir do
    mode '0700'
    owner 'root'
    group 'root'
  end

  file cert_path do
    content node['supermarket_wrapper']['cert']
    mode '0644'
    owner 'root'
    group 'root'
  end

  file cert_key_path do
    content node['supermarket_wrapper']['cert_key']
    mode '0600'
    owner 'root'
    group 'root'
  end
  config['ssl'] = {}
  config['ssl']['certificate'] = cert_path
  config['ssl']['certificate_key'] = cert_key_path
end

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
