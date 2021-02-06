#!/usr/bin/env bash
#
# configure proxy settings and related environment
#
# specify these env vars:
#
#   PROXY_HOST=<HOST>
#   PROXY_PORT=<PORT>
#
# NOTE: script is tested on UBUNTU 18.04 with GNOME
#
# Edit the below as you prefer
#

NO_PROXY="['localhost', '10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16', '127.0.0.0/8', '::1', '*.local']"

# optionally set the Dropbox proxy
#dropbox proxy manual http "$PROXY_HOST" $PROXY_PORT 1> /dev/null

gsettings set org.gnome.system.proxy mode 'manual'
gsettings set org.gnome.system.proxy use-same-proxy false
gsettings set org.gnome.system.proxy.http enabled false
gsettings set org.gnome.system.proxy ignore-hosts "$NO_PROXY"
gsettings set org.gnome.system.proxy.http host "$PROXY_HOST"
gsettings set org.gnome.system.proxy.http port $PROXY_PORT
gsettings set org.gnome.system.proxy.https host "$PROXY_HOST"
gsettings set org.gnome.system.proxy.https port $PROXY_PORT
gsettings set org.gnome.system.proxy.socks host "$PROXY_HOST"
gsettings set org.gnome.system.proxy.socks port $PROXY_PORT
gsettings set org.gnome.system.proxy.ftp host "$PROXY_HOST"
gsettings set org.gnome.system.proxy.ftp port $PROXY_PORT

export http_proxy=http://$PROXY_HOST:$PROXY_PORT/
export https_proxy=http://$PROXY_HOST:$PROXY_PORT/
export ftp_proxy=http://$PROXY_HOST:$PROXY_PORT/
export socks_proxy=http://$PROXY_HOST:$PROXY_PORT/
export no_proxy="$(echo $NO_PROXY | tr -d "'" | tr -d "[" | tr -d "]")"

export HTTP_PROXY=http://$PROXY_HOST:$PROXY_PORT/
export HTTPS_PROXY=http://$PROXY_HOST:$PROXY_PORT/
export FTP_PROXY=http://$PROXY_HOST:$PROXY_PORT/
export SOCKS_PROXY=http://$PROXY_HOST:$PROXY_PORT/
export NO_PROXY="$(echo $NO_PROXY | tr -d "'" | tr -d "[" | tr -d "]")"

# in case using LXC uncomment the below
#lxc config set core.proxy_http "http://$PROXY_HOST:$PROXY_PORT"
#lxc config set core.proxy_https "http://$PROXY_HOST:$PROXY_PORT"
#lxc config set core.proxy_ignore_hosts "$(echo $NO_PROXY | tr -d "'" | tr -d "[" | tr -d "]")"
