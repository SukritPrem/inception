#!/bin/bash

service mariadb start

sleep 5

if [ ! -d "/var/lib/mysql" ];then
    echo "ERROR CREATE FOLDER /var/lib/mysql"
    exit 1
fi

if [ ! -d "/var/lib/mysql/$MYSQL_NAME" ];then
        mariadb <<EOF
    CREATE DATABASE IF NOT EXISTS ${MYSQL_NAME};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_NAME}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOF
else
    echo "Already exits"
    service mariadb stop
    exec "$@"
fi

if [ -f "$MYSQL_NAME_FILE" ];then
    # Move database_dump.sql to /var/lib/mysql/$DB_NAME directory if $DB_NAME directory exists
    echo "Hello1"
    mv $MYSQL_NAME_FILE "/var/lib/mysql"
fi

if [ -f "/var/lib/mysql/$MYSQL_NAME_FILE" ]; then
    echo "Hi"
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_NAME" < "/var/lib/mysql/$MYSQL_NAME_FILE"
fi

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

service mariadb stop

chown -R mysql:mysql /var/lib/mysql  # Change ownership to mysql user and group

# adduser --disabled-password --gecos "" --uid $UID "$USER"


chmod -R 777 /var/lib/mysql  

# #For host machine delete
# chmod -R 777 /var/lib/mysql

exec "$@"
