#!/bin/sh

if [ ! -f /var/www/html/.env ]; then
  cp /var/www/html/.env.example /var/www/html/.env
fi

if ! grep -q APP_KEY /var/www/html/.env || [ -z "$(grep APP_KEY /var/www/html/.env | cut -d '=' -f2)" ]; then
  php /var/www/html/artisan key:generate
fi

exec "$@"
