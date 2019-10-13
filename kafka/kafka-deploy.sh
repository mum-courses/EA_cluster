#!/usr/bin/env bash
vms=( "manager1" "manager2" "manager3"
      "worker1" "worker2" "worker3" )

docker-machine env manager1
eval $(docker-machine env manager1)



docker stack deploy -c ./kafka-compose.yaml kafka
