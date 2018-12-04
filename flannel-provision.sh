#!/usr/bin/env bash

echo "installing flannel"
yum install -y flannel
echo "updating flanneld configurations"
sed -i -e 's/127\.0\.0\.1/172.17.8.101/' /etc/sysconfig/flanneld
sed -i -e 's/atomic\.io/coreos.com/' /etc/sysconfig/flanneld
sed -i -e '/FLANNEL_OPTIONS=/d' /etc/sysconfig/flanneld
echo 'FLANNEL_OPTIONS="--ip-masq --iface=enp0s8"' | tee -a /etc/sysconfig/flanneld
echo "enabling flanneld"
systemctl enable flanneld
echo "starting flanneld"
systemctl start flanneld
