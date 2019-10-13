#!/usr/bin/env bash
vms=( "manager1" "manager2" "manager3"
      "worker1" "worker2" "worker3" )

docker-machine env manager1
eval $(docker-machine env manager1)

export network=overlay_net

docker stack deploy -c ./student-service-compose.yaml student-service
