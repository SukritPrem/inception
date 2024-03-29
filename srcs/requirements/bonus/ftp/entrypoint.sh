#!/bin/bash


# Add user
useradd -m myftpuser

# Set password for the user (replace 'password' with your desired password)
echo 'myftpuser:password' | chpasswd

mkdir -p /var/run/vsftpd/empty

mkdir -p /var/www/html

chown myftpuser:myftpuser /var/www/html

chmod -R 755 /var/www/html

exec "$@"