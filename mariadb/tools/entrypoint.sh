#!/bin/bash

service mariadb start

sleep 5

if [ ! -d "/var/lib/mysql" ];then
    echo "ERROR CREATE FOLDER /var/lib/mysql"
    exit 1
fi

if [ -f "$DB_NAME_FILE" ]; then
    # Move database_dump.sql to /var/lib/mysql/$DB_NAME directory if $DB_NAME directory exists
    echo "Hello1"
    mv $DB_NAME_FILE "/var/lib/mysql"
    if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
        mariadb <<EOF
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOF
    fi
    
    if [ -f "/var/lib/mysql/$DB_NAME_FILE" ]; then
        echo "Hi"
        mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "/var/lib/mysql/$DB_NAME_FILE"
    else
        mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "/var/lib/mysql/$DB_NAME_FILE"
    fi
else
    echo "Hello2"
    mariadb <<EOF
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOF

    # Dump the database into /var/lib/mysql/$DB_NAME/database_dump.sql
    mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "/var/lib/mysql/$DB_NAME_FILE"
fi


service mariadb stop

chown -R mysql:mysql /var/lib/mysql  # Change ownership to mysql user and group

chmod -R 755 /var/lib/mysql  

#For host machine delete
chmod -R 777 /var/lib/mysql

exec "$@"
