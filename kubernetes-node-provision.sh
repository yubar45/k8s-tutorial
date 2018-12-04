echo "installing kubernetes-node"
yum install -y kubernetes-node
echo "updating kubelet configurations"
sed -i -e 's/master=http:\/\/127\.0\.0\.1/master=http:\/\/172.17.8.101/' /etc/kubernetes/config
sed -i -e 's/KUBELET_ADDRESS="--address=127\.0\.0\.1"/KUBELET_ADDRESS="--address=0.0.0.0"/' /etc/kubernetes/kubelet 
sed -i -e 's/--api-servers=http:\/\/127\.0\.0\.1/--api-servers=http:\/\/172.17.8.101/' /etc/kubernetes/kubelet
sed -i -e 's/KUBELET_HOSTNAME="--hostname-override=127\.0\.0\.1"/KUBE_LET_HOSTNAME=/' /etc/kubernetes/kubelet
echo "installing subscription-manager"
yum install -y subscription-manager
echo "downloading redhat pem certificate"
wget -O /etc/rhsm/ca/redhat-uep.pem https://raw.githubusercontent.com/candlepin/python-rhsm/master/etc-conf/ca/redhat-uep.pem
echo "enabling kubelet & kube-proxy"
systemctl enable kubelet
systemctl enable kube-proxy
echo "starting kubelet & kube-proxy"
systemctl start kubelet
systemctl start kube-proxy
