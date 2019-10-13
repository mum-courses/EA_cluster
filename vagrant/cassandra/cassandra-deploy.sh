#!/usr/bin/env bash


docker stack deploy -c ./cassandra-compose.yaml cassandra

#had to scale one at a time for Cassandra seed issue, ref: https://github.com/docker-library/cassandra/issues/94
docker service scale cassandra_cassandra=3
