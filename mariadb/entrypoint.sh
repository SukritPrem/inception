#!/bin/bash



service mariadb start

sleep 5

mkdir test

service mariadb stop

chown -R mysql:mysql /var/lib/mysql  # Change ownership to mysql user and group

chmod -R 755 /var/lib/mysql  

exec "$@"