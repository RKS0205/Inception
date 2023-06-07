#!/bin/bash

mysqld_safe &
service mysql start

# Create Wordpress database
mysql -e "CREATE DATABASE $DB_NAME"

# Create Mariadb/Wordpress user
mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS_USER'"

# Grant privileges to user
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* to '$DB_USER'@'%'"

# Make sure that NOBODY can access the server without a password
mysql -e "ALTER USER '$DB_ROOT'@'localhost' IDENTIFIED BY '$DB_PASS_ROOT';FLUSH PRIVILEGES"