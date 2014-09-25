#!/bin/bash

if [ ! -d /var/www ]; then
    echo 'No application found in /var/www'
    exit 1;
fi

cd /var/www

if [ ! -d vendor ]; then
    composer install
fi

/bin/sed -i "s/<APP_SERVER_NAME>/${APP_SERVER_NAME}/" /etc/nginx/sites-enabled/default

exec /usr/bin/supervisord
