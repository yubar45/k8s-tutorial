Vagrant.configure("2") do |config|
  
	config.vm.define "master" do |master|

		master.vm.box = "geerlingguy/centos7"

		master.vm.hostname = "master"

		master.vm.box_check_update = false

		master.vm.network "private_network", ip: "172.17.8.101"

		master.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
		end

		master.vm.provision "etcd", type:"shell", path:"etcd-provision.sh"
		master.vm.provision "flannel", type:"shell", path:"flannel-provision.sh"
		master.vm.provision "docker", type:"shell", path:"docker-provision.sh"
		master.vm.provision "kubernetes-master", type:"shell", path:"kubernetes-master-provision.sh"
		master.vm.provision "kubernetes-node", type:"shell", path:"kubernetes-node-provision.sh"
	end

	$nodes_count=3

	(2..$nodes_count).each do |i|
		config.vm.define "node#{i}" do |node|

			node.vm.box = "geerlingguy/centos7"

			node.vm.hostname = "node#{i}"

			node.vm.box_check_update = false

			node.vm.network "private_network", ip: "172.17.8.#{i+100}"

			node.vm.provider "virtualbox" do |vb|
				vb.memory = "1024"
			end

			node.vm.provision "flannel", type:"shell", path:"flannel-provision.sh"
			node.vm.provision "docker", type:"shell", path:"docker-provision.sh"
			node.vm.provision "kubernetes-node", type:"shell", path:"kubernetes-node-provision.sh"
		end
	end
end
