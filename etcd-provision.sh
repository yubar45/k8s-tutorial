#!/usr/bin/env bash

echo "installing etcd"
yum install -y etcd
echo "updating etcd configurations"
sed -i -e 's/localhost/0.0.0.0/g' /etc/etcd/etcd.conf
echo "enabling etcd"
systemctl enable etcd
echo "starting etcd"
systemctl start etcd
echo "putting flannel network setting in etcd"
etcdctl set /coreos.com/network/config '{"Network": "10.33.0.0/16"}'
