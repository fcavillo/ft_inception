#!/bin/bash

echo "mysql setup 0"
service mysql start

if mysql -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "use ${MYSQL_DATABASE_NAME}";
then
    echo "Database $MYSQL_DATABASE_NAME already exists. Proceed to next step."
else
    echo "Installing db ..."
    mysql_install_db > /dev/null 2>&1

    echo "Creating user ..."
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' identified by '${MYSQL_PASSWORD}';\
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE_NAME};\
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    #set 12345 as password for root, reload table
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
    echo 'Db configured'
fi

mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
#service mysql stop
echo "Launching mysqld"
mysqld

echo "Quit mysqld"
