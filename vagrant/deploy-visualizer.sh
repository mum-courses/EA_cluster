#!/usr/bin/env bash
docker service create \
  --name swarm-visualizer \
  --publish 5001:8080/tcp \
  --constraint node.role==manager \
  --mode global \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --env "SERVICE_IGNORE=true" \
  dockersamples/visualizer:latest

managerIP=$(docker-machine ls | grep "node-1" | grep "Running" | head -n 1 | awk '{print $1}' | xargs docker-machine ip)
echo "check visualizer UI: $managerIP:5001"
echo "visualizer deployment done!"