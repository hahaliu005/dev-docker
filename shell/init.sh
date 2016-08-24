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
    - ${WEB_DIR}:/usr/local/openresty/nginx/html

" > ${CURRENT_DIR}/docker-compose.yml
