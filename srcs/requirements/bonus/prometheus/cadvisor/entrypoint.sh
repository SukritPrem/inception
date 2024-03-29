#!/bin/bash

# wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && sh /tmp/netdata-kickstart.sh

wget https://github.com/google/cadvisor/releases/download/v0.39.3/cadvisor

chmod +x cadvisor
# echo "Hello cp"
# cp netdata.conf /etc/netdata/netdata.conf 

exec "$@"