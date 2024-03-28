#!/bin/bash

service php7.4-fpm start

sleep 5

service php7.4-fpm stop

wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz 

# mkdir /var/www

# mkdir /var/www/html

mkdir -p /var/www/html

tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html 

chown -R www-data.www-data /var/www/html/wordpress 

chmod -R 755 /var/www/html/wordpress

cd /var/www/html/wordpress

cp wp-config-sample.php wp-config.php

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp plugin install redis-cache --activate --path="/var/www/html/wordpress" --allow-root

sleep 5
# Generate wp-config.php content
sed -i "s/database_name_here/$MYSQL_NAME/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
sed -i "s/localhost/$MYSQL_ADDRESS/" wp-config.php
# Keep the container running


cd /var/www/html/wordpress

# config add redis
# Change directory for add config redis to wordpress
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT '6379' --raw --allow-root
# wp config set WP_REDIS_PREFIX 'my-moms-site' --raw --no-cast
wp config set WP_REDIS_DATABASE '0' --raw --allow-root
# wp config set WP_REDIS_TIMEOUT 1 --raw --no-cast
# wp config set WP_REDIS_READ_TIMEOUT 1 --raw --no-cast
wp config set WP_REDIS_CLIENT 'phpredis' --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root
wp redis enable --allow-root

#change host_url
#wp search-replace "http://localhost" "http://spipitku.42.fr" --all-tables --allow-root
wp option update home "http://spipitku.42.fr" --allow-root
wp option update siteurl "http://spipitku.42.fr" --allow-root

# cd /

# useradd -u 1000 test

# chmod 666 /var/log/php7.4-fpm.log 

# su - test
useradd -m -s /bin/bash site1user

usermod -a -G www-data site1user

chown -R root:www-data /var/log/php7.4-fpm.log 

chmod -R 775 /var/log/php7.4-fpm.log
# chmod -R 775 /run/php/php7.4-fpm.pid

chmod -R 775 /run/php/  

#For host machine delete
chmod -R 777 /var/www/html

su -c '/usr/sbin/php-fpm7.4 -F' -s /bin/bash site1user

# exec "$@"

