#!/bin/bash

service mariadb start

sleep 5

service mariadb stop

exec "$@"