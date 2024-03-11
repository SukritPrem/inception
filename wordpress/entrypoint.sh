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

cd /var/www/html/wordpress

cp wp-config-sample.php wp-config.php

# Generate wp-config.php content
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php
# Keep the container running
exec "$@"
