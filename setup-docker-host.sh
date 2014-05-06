#!/bin/sh
set -ue


if [ `id -u` -eq 0 ]; then
	echo "error: This script assumes that you are non-root operation user for docker." >&2
	exit 1
fi

#sudo iptables -t nat -A POSTROUTING -s 172.17.0.0/24 -j MASQUERADE

if [ ! -f /etc/sysctl.d/10-docker-enable-ip-forward.conf ]; then
	echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/10-docker-enable-ip-forward.conf
	if [ ! -f /etc/sysctl.conf ]; then
		# Latest ArchLinux does not have /etc/sysctl.conf
		sudo sysctl --system
	else
		sudo sysctl -p
	fi
fi

if fgrep -q "alias dl='sudo docker -l -q'" ~/.bashrc; then
	echo "alias dl='sudo docker -l -q'" >>~/.bashrc
fi


echo 'Configuration for Docker...Done!'
exit 0
