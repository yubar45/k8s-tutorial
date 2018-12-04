#!/usr/bin/env bash

echo "installing docker"
yum install -y docker
echo "updating docker configurations"
sed -i -e '/OPTIONS=/d' /etc/sysconfig/docker
source /run/flannel/subnet.env
echo "OPTIONS='--selinux-enabled --log-driver=journald --signature-verification=false --bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU}'" | tee -a /etc/sysconfig/docker
echo "creating docker group"
groupadd docker
usermod -a -G docker vagrant
echo "enabling docker"
systemctl enable docker
echo "starting docker"
systemctl start docker
