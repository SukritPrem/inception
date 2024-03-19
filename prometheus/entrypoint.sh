# !/bin/bash

# groupadd --system prometheus

# useradd -s /sbin/nologin --system -g prometheus prometheus

# systemctl daemon-reload
# sleep 2
# systemctl start prometheus
# sleep 2
# systemctl enable prometheus
# sleep 2
# exec "$@"

