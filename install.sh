#!/bin/sh
set -ue

if [ `id -u` -ne 0 ]; then
	echo 'error: you must be root' >&2
	exit 1
fi
cd $(dirname $0)
/usr/bin/install -o root -g root -m 644 default /etc/default/docker-autostart
/usr/bin/install -o root -g root -m 755 docker-autostart /etc/init.d/docker-autostart
