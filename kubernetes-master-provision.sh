echo "installing kubernetes master and kubernetes client"
yum install kubernetes-master kubernetes-client -y
echo "updating kubernetes configurations"
sed -i -e 's/insecure-bind-address=127.0.0.1/insecure-bind-address=0.0.0.0/g' /etc/kubernetes/apiserver
sed -i -e 's/--service-cluster-ip-range=10\.254\.0\.0\/16/--service-cluster-ip-range=10.33.0.0\/16/g' /etc/kubernetes/apiserver
sudo sed -i -e 's/^KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota"/#KUBE_ADMISSION_CONTROL=""/' /etc/kubernetes/apiserver

echo "updating kubernetes systemd files"
sed -i '/Documentation/ a After=kube-apiserver.service' /usr/lib/systemd/system/kube-controller-manager.service
sed -i '/After/ a Wants=kube-apiserver.service' /usr/lib/systemd/system/kube-controller-manager.service
sed -i '/Documentation/ a After=kube-apiserver.service' /usr/lib/systemd/system/kube-scheduler.service
sed -i '/After/ a Wants=kube-apiserver.service' /usr/lib/systemd/system/kube-scheduler.service
echo "enabling kubernetes services"
systemctl enable kube-apiserver
systemctl enable kube-scheduler
systemctl enable kube-controller-manager
echo "starting kubernetes services"
systemctl start kube-apiserver
systemctl start kube-scheduler
systemctl start kube-controller-manager
