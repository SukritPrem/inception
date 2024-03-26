#!/bin/bash

rm /etc/nginx/sites-enabled/default

rm /etc/nginx/sites-available/default 

#For host machine delete
chmod -R 777 /var/www/html


exec "$@"



