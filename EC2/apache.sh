#install wordpress on a ubuntu machine using bash script using LAMP Stack

#!/bin/bash
# Check if user is root
if [ "$(id -u)" != "
0" ]; then
echo "This script must be run as root"
exit 1
fi
# Update packages and upgrade system
sudo apt update && aptitude upgrade -y
# Install Apache2, PHP5, MySQL,
# and Perl (for mod_perl)
sudo apt install apache2 php5 libapache2
modphp5 mysql perl -y
# Get the latest WordPress version
wget http://wordpress.org/latest.
tar xzvf latest.tar.gz
cd wordpress
# Set up MySQL database for WordPress
mysqladmin -u root password 'password'
cat << EOF > ./wp-config.
php
define('DB_NAME', 'wordpress');
define('DB_USER', 'root');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'localhost');
EOF
# Add virtual hosts for WordPress and
# Apache2 default site
cp ../sites-available/000-default /etc/apache2/sites-available
cp ../sites-available/wordpress .
/etc/apache2/sites-enabled
a2dissite default
a2ensite wordpress
service apache2 restart
# Print out some useful information
IPADDR=$(hostname -I | awk '{
    print $1}')
    echo "WordPress has been installed on your server
    at:"
    echo "http://$IPADDR/"
    exit 0

