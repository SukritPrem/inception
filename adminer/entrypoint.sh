#!/bin/bash

service php7.4-fpm start

mkdir -p /var/www/html

sleep 5

service php7.4-fpm stop


mv adminer-4.8.1.php /var/www/html/

exec "$@"