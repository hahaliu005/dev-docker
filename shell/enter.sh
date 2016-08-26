#!/bin/bash
. ./shell/head.sh
. ./shell/config.sh

DOCKER_NAME=`docker-compose ps | awk '{print $1}' | grep _$1_`
echo $DOCKER_NAME

if [[ -z "$DOCKER_NAME" ]]; then
  echo "Can not find name like: $1"
else
  docker exec -it $DOCKER_NAME /bin/bash
fi
