# chef_supermarket

## Overview
Use this cookbook to install, configure and start a supermarket server

## Usage
Include this cookbook's default recipe in your run list.


## Attributes
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|package_version|The version of supermarket to install|string|3.3.3|no|
|package_repo|The channel to install from|string|stable|no|
|chef_server_url|The url of a chef server to use as an oauth server|string|''|no|
|chef_oauth2_app_id|The app id to use for the oauth server|string|''|no|
|chef_oauth2_secret|The secret to use for the oauth server|string|''|no|
|fqdn|The hostname to use for the supermarket server|string|''|no|
