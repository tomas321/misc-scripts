#!/usr/bin/env bash
#
# set the following environment variables:
#
#   PROXY_HOST=<HOST>
#   PROXY_PORT=<PORT>
#
# usage:
#   $0 [dowm | off | unset]
#

if [[ "$1" == "unset" ]] || [[ "$1" == "off" ]] || [[ "$1" == "down" ]] ; then
	echo 'setting off APT proxy'
	sed -i '/proxy/d' /etc/apt/apt.conf
	exit
fi

grep -i "acquire::http::proxy" /etc/apt/apt.conf
if [ "$?" -eq 0 ]; then
	echo 'APT proxy is already set'
	exit
fi

if [ ! -f '/etc/apt/apt.conf' ]; then
	touch /etc/apt/apt.conf
fi

echo "Acquire::http::Proxy \"http://$PROXY_HOST:$PROXY_PORT/\";" >> /etc/apt/apt.conf
echo "Acquire::ftp::Proxy \"http://$PROXY_HOST:$PROXY_PORT/\";" >> /etc/apt/apt.conf
echo "Acquire::https::Proxy \"http://$PROXY_HOST:$PROXY_PORT/\";" >> /etc/apt/apt.conf

echo 'APT proxy set'
