#!/usr/bin/env bash

docker stack deploy -c ./kafka-compose.yaml kafka
