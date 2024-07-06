#!/bin/bash
set -e

# Change to the Bedrock directory
cd /srv/bedrock

# Run composer install
composer install


# Initialize WordPress if it's not already installed
wp core is-installed || wp core install --url=$WP_HOME --title="Bedrock Site" --admin_user=admin --admin_password=admin_password --admin_email=admin@example.com

# Install and activate the login command
wp package install aaemnnosttv/wp-cli-login-command || echo 'wp-cli-login-command is already installed'
wp login install --activate --yes --skip-plugins --skip-themes

# Create a login link
wp login as 1

# Start supervisord
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
