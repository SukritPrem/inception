#!/bin/bash

service php7.4-fpm start

sleep 5

service php7.4-fpm stop

wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz 

mkdir /var/www

mkdir /var/www/html

tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html 

chown -R www-data.www-data /var/www/html/wordpress 

chmod -R 755 /var/www/html/wordpress

# Keep the container running
exec "$@"
