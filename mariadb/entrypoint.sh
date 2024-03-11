#!/bin/bash



service mariadb start

sleep 5

if [ -d "/var/lib/mysql/$DB_NAME" ]; then
    # Move database_dump.sql to /var/lib/mysql/$DB_NAME directory if $DB_NAME directory exists
    mv database_dump.sql "/var/lib/mysql"
    echo "Hello"
    if [ -f "/var/lib/mysql/database_dump.sql" ]; then
        echo "Hi"
        mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "/var/lib/mysql/database_dump.sql"
    fi
    echo "Hello1"
else
    mariadb <<EOF
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOF

    # Dump the database into /var/lib/mysql/$DB_NAME/database_dump.sql
    mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "/var/lib/mysql/database_dump.sql"
fi


service mariadb stop

chown -R mysql:mysql /var/lib/mysql  # Change ownership to mysql user and group

chmod -R 755 /var/lib/mysql  

exec "$@"
