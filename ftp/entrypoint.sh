#!/bin/bash


# Add user
useradd -m myftpuser

# Set password for the user (replace 'password' with your desired password)
echo 'myftpuser:password' | chpasswd


mkdir -p /var/run/vsftpd/empty

exec "$@"