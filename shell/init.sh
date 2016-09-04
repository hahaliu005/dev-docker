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

image:
  build: $DOCKER_DIR/image
  ports:
    - `expr ${PORT_OFFSET} + 90`:80
  volumes:
    - ${WEB_DATA_DIR}/image:/var/www

media:
  build: $DOCKER_DIR/media
  ports:
    -   `expr ${PORT_OFFSET} + 91`:80
  volumes:
    - ${WEB_DATA_DIR}/video/released:/var/www

portal:
  build: ${DOCKER_DIR}/web
  ports:
    - `expr ${PORT_OFFSET} + 80`:80
  links:
    - mysql
    - redis
  volumes:
    - ${PORTAL_DIR}:/var/www
    - ${WEB_DATA_DIR}:/var/www/storage/data

admin:
  build: ${DOCKER_DIR}/web
  ports:
    - `expr ${PORT_OFFSET} + 81`:80
  links:
    - mysql
    - redis
  volumes:
    - ${ADMIN_DIR}:/var/www
    - ${WEB_DATA_DIR}:/var/www/storage/data

trans:
  build: ${DOCKER_DIR}/trans
  ports:
    - `expr ${PORT_OFFSET} + 82`:80
  links:
    - mysql
    - redis
  volumes:
    - ${TRANS_DIR}:/var/www
    - ${WEB_DATA_DIR}:/var/www/storage/data

" > ${CURRENT_DIR}/docker-compose.yml

# 获取当前用户的user_id与group_id, 以便在dockerfile中动态配置运行的用户
execCmd "echo ${DOCKER_USER_ID} > ${CURRENT_DIR}/.docker_user_id"
execCmd "find dockers -maxdepth 1  -type d | xargs -I {} cp ./.docker_user_id {}"
execCmd "echo ${DOCKER_GROUP_ID} > ${CURRENT_DIR}/.docker_group_id"
execCmd "find dockers -maxdepth 1  -type d | xargs -I {} cp ./.docker_group_id {}"

myEcho "Init ended ..."
