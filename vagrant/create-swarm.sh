#!/usr/bin/env bash

source ./variables.sh

SWARM_MANAGER_IP=$(docker-machine ip $manager_node)
echo ${SWARM_MANAGER_IP}

docker-machine ssh $manager_node \
  "docker swarm init \
  --advertise-addr ${SWARM_MANAGER_IP}"

docker-machine env $manager_node
eval $(docker-machine env $manager_node)

MANAGER_SWARM_JOIN=$(docker-machine ssh $manager_node "docker swarm join-token manager")
MANAGER_SWARM_JOIN=$(echo ${MANAGER_SWARM_JOIN} | grep -E "(docker).*(2377)" -o)
MANAGER_SWARM_JOIN=$(echo ${MANAGER_SWARM_JOIN//\\/''})
echo ${MANAGER_SWARM_JOIN}

# two other manager nodes
for i in  $( seq 2 $manager_number)
do
  docker-machine ssh node-$i "${MANAGER_SWARM_JOIN}"
done

WORKER_SWARM_JOIN=$(docker-machine ssh $manager_node "docker swarm join-token worker")
WORKER_SWARM_JOIN=$(echo ${WORKER_SWARM_JOIN} | grep -E "(docker).*(2377)" -o)
WORKER_SWARM_JOIN=$(echo ${WORKER_SWARM_JOIN//\\/''})
echo ${WORKER_SWARM_JOIN}

# remaining worker nodes
for i in $(seq $((manager_number+1)) $vm_number)
do
  docker-machine ssh node-$i ${WORKER_SWARM_JOIN}
done

docker node ls


echo "Creating overlay_net"

eval $(docker-machine env $manager_node)
export network=overlay_net
docker network create \
  --driver overlay \
  --subnet=10.0.0.0/16 \
  --ip-range=10.0.11.0/24 \
  --opt encrypted \
  --attachable=true \
  $network

echo "Script completed..."
