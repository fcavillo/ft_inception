#!/bin/bash

# Start services
service nginx start
service mysql start
service php7.3-fpm start

chown -R www-data: /var/www

# Nginx server configuration
if  [ $AUTO_INDEX = "off" ]
then
	sed -i 's/autoindex on/autoindex off/g' srcs/default
fi
rm /etc/nginx/sites-available/default
cp srcs/default /etc/nginx/sites-available/
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# SSL configuration
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/server.key -out /etc/nginx/server.crt -subj "/C=US/ST=Utah/L=Lehi/O=Your Company, Inc./OU=IT/CN=yourdomain.comi"

# PhpMyAdmin install
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.tar.gz
tar -xf phpMyAdmin-4.9.2-all-languages.tar.gz
mv phpMyAdmin-4.9.2-all-languages phpmyadmin
mv phpmyadmin /var/www/
rm -rf phpMyAdmin-4.9.2-all-languages.tar.gz
chmod 755 -R /var/www/phpmyadmin && chown -R www-data: /var/www/phpmyadmin
cp srcs/config.inc.php /var/www/phpmyadmin/

# Create MySQL database profile
mysql --execute "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';CREATE DATABASE wordpress;GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';FLUSH PRIVILEGES;"

# Wordpress install
wget -c http://fr.wordpress.org/latest-fr_FR.tar.gz
tar -xf latest-fr_FR.tar.gz
mkdir /var/www/wordpress/
mv wordpress/* /var/www/wordpress
rm latest-fr_FR.tar.gz
chmod 755 -R /var/www/wordpress
chown -R www-data: /var/www/wordpress
cp srcs/wp-config.php /var/www/wordpress/

# Nginx restart
service nginx restart

/bin/sh
