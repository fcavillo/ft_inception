#!/bin/bash

service mysql start
mysql_install_db

# Create MySQL database profile
mysql --execute "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';\
CREATE DATABASE ${MYSQL_DATABASE};GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';\
FLUSH PRIVILEGES;"

echo "mysql started"

#service mysql stop

echo "mysql stopped"


mysqld
