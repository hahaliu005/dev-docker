#!/bin/bash
. ./shell/head.sh
. ./shell/config.sh

myEcho "Begin to init ... "

echo "
mysql:
  build: ${DOCKER_DIR}/mysql
  ports:
    - `expr ${PORT_OFFSET} + 3306`:3306
  environment:
    MYSQL_ROOT_PASSWORD: ${MYSQL_PASSWORD}
    MYSQL_DATABASE: ${MYSQL_DATABASE}
  volumes:
    - ${MYSQL_DATA_DIR}:/var/lib/mysql

redis:
  build: ${DOCKER_DIR}/redis
  ports:
    - `expr ${PORT_OFFSET} + 6379`:6379

web:
  build: ${DOCKER_DIR}/web
  ports:
    - `expr ${PORT_OFFSET} + 80`:80
  links:
    - mysql
    - redis
  volumes:
    - ${WEB_DIR}:/var/www

" > ${CURRENT_DIR}/docker-compose.yml

# 获取当前用户的user_id与group_id, 以便在dockerfile中动态配置运行的用户
execCmd "echo ${DOCKER_USER_ID} > ${CURRENT_DIR}/.docker_user_id"
execCmd "find dockers -maxdepth 1  -type d | xargs -I {} cp ./.docker_user_id {}"
execCmd "echo ${DOCKER_GROUP_ID} > ${CURRENT_DIR}/.docker_group_id"
execCmd "find dockers -maxdepth 1  -type d | xargs -I {} cp ./.docker_group_id {}"

myEcho "Init ended ..."
