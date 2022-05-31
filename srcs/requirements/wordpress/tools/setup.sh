#wait until db is setup
while ! mysql -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD > /dev/null 2>&1; do echo "Waiting for db ..."; sleep 5; done
echo 'Mariadb db is usable !'

if  [ ! -f /var/www/wordpress/wp-config.php ]; then
    while  [ ! -f /var/www/wordpress/wp-config.php ]; do
        echo 'Setting up wordpress ...'
        wp core config --allow-root --dbname=$MYSQL_DATABASE_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'
    done
    # while ! wp core is-installed --allow-root --path='/var/www/wordpress'
    # do
        echo "Installing wordpress and creating admin account ..."
        wp core install --allow-root --url='fcavillo.42.fr' --title='WordPress for ft_inception' --admin_user=$WP_LOGIN --admin_password=$WP_PASS  --admin_email="admin@admin.fr" --path='/var/www/wordpress'
    # done
    echo "Wordpress installed !"
    wp user create --allow-root $WPU_1LOGIN otheruser@user.com --user_pass=$WPU_1PASS --role=contributor --path='/var/www/wordpress'
fi
echo 'Launching Wordpress'
php-fpm7.3 -F --nodaemonize