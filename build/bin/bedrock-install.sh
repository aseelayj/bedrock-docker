#!/bin/bash
set -e

# Change to the Bedrock directory
cd /srv/bedrock

# Run composer install as bedrockuser
su bedrockuser -c 'composer install --no-dev --optimize-autoloader'

# Initialize WordPress if it's not already installed
su bedrockuser -c 'wp core is-installed || wp core install --url='"$WP_HOME"' --title="Bedrock Site" --admin_user=admin --admin_password=admin_password --admin_email=admin@example.com'

# Install and activate the login command as bedrockuser
su bedrockuser -c 'wp package install aaemnnosttv/wp-cli-login-command || echo "wp-cli-login-command is already installed"'
su bedrockuser -c 'wp login install --activate --yes --skip-plugins --skip-themes'

# Create a login link as bedrockuser
su bedrockuser -c 'wp login as 1'

# Start supervisord
#exec /usr/bin/supervisord -n -c /etc/supervisord.conf
