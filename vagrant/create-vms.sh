#!/usr/bin/env bash

source ./variables.sh

vagrant box add "envimation/ubuntu-xenial-docker" "https://atlas.hashicorp.com/envimation/boxes/ubuntu-xenial-docker"
vagrant plugin install vagrant-vbguest
vagrant up


for i in $( seq 1 $vm_number )
do
	node="node-$i"
	ip="192.168.100.10$i"
	echo "docker-machine create --> $node"
    docker-machine create --driver generic --generic-ip-address=$ip   --generic-ssh-user=vagrant --generic-ssh-key=keys/id_rsa $node
done

echo "Script completed..."
