#!/bin/bash


service php7.4-fpm start


# Keep the container running
exec "$@"
