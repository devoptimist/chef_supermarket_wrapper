name 'chef_supermarket_wrapper'
maintainer 'Steve Brown'
maintainer_email 'sbrown@chef.io'
license 'Apache-2.0'
description 'Installs/Configures a chef supermarket'
long_description 'Installs/Configures a chef supermarket'
version '0.1.5'
chef_version '>= 13.0'
depends 'chef-ingredient'

%w(redhat centos debian ubuntu suse).each do |os|
  supports os
end

issues_url 'https://github.com/devoptimist/chef_supermarket_wrapper/issues'
source_url 'https://github.com/devoptimist/chef_supermarket_wrapper'
