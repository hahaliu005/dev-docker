#!/bin/bash

sudo service crond start

crontab /etc/cron.d/web_cron

sudo /usr/bin/supervisord -c /etc/supervisord.conf
