#!/usr/bin/env bash


docker-machine ls | awk '{print $1}' | grep -v "NAME" | xargs docker-machine rm -y


vagrant destroy -f

echo "Script completed..."
