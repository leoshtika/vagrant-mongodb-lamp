#!/usr/bin/env bash

# Add repository for PHP (7.3)
add-apt-repository ppa:ondrej/php

# MongoDB Import the public key used by the package management system and create a list file for MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# Update the list of available packages
apt update -y

# Install GIT
apt install -y git

# Install Apache
apt install -y apache2

# Remove 'html' folder and add a symbolic link, only if it doesn't already exists
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant /var/www/html
fi

# Change AllowOverride in apache2.conf for the .htaccess to work
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
# Enable Apache's mod_rewrite
sudo a2enmod rewrite

# Install the MongoDB packages (Release 4.2.0)
apt install -y mongodb-org=4.2.0 mongodb-org-server=4.2.0 mongodb-org-shell=4.2.0 mongodb-org-mongos=4.2.0 mongodb-org-tools=4.2.0

# Pin the MongoDB package at the currently installed version (4.2.0)
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# Start MongoDB and enable auto start when system reboots
systemctl start mongod
systemctl enable mongod

# Install PHP together with some of the most commonly used extensions
apt -y install php7.3 libapache2-mod-php7.3 curl php7.3-curl php7.3-gd php7.3-mbstring php7.3-xml php7.3-zip php7.3-intl php7.3-mongodb php7.3-dev php-pear

# Configure PHP
sed -i s/'display_errors = Off'/'display_errors = On'/ /etc/php/7.3/apache2/php.ini

# Install MongoDB PHP Drivers and enable them
pecl install mongodb

# Install Composer
if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
fi

# Restart Apache
systemctl restart apache2

# Add an alias for codecept
echo "alias codecept='php /vagrant/vendor/bin/codecept'" >> /home/vagrant/.bashrc

echo "============================================"
echo "Your development LAMP stack is ready"
echo "URL: http://localhost:4000"
echo "Synced folder: 'vagrant ssh' & 'cd /vagrant'"
echo "============================================"