#!/usr/bin/env bash
#
# configure proxy settings and related environment
#
# NOTE: script is tested on UBUNTU 18.04 with GNOME
#
# Edit the below as you prefer
#

gsettings set org.gnome.system.proxy mode 'none'

# if your using Dropbox uncomment the line below
#dropbox proxy none

unset http_proxy
unset https_proxy
unset ftp_proxy
unset socks_proxy
unset all_proxy
unset no_proxy

unset HTTP_PROXY
unset HTTPS_PROXY
unset FTP_PROXY
unset SOCKS_PROXY
unset ALL_PROXY
unset NO_PROXY

# for LXC usage uncomment th elines below
#lxc config unset core.proxy_http
#lxc config unset core.proxy_https
#lxc config unset core.proxy_ignore_hosts
