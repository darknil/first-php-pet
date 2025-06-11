#!/bin/sh

# Копируем .env, если он отсутствует
if [ ! -f /var/www/html/.env ]; then
  cp /var/www/html/.env.example /var/www/html/.env
fi

# Генерируем ключ, если не установлен
if ! grep -q APP_KEY /var/www/html/.env || [ -z "$(grep APP_KEY /var/www/html/.env | cut -d '=' -f2)" ]; then
  php /var/www/html/artisan key:generate
fi

# Ждем, пока БД будет доступна и запускаем миграции
echo "⏳ Ждем базу данных и применяем миграции..."
until php /var/www/html/artisan migrate --force; do
  echo "❌ База еще недоступна. Повтор через 3 секунды..."
  sleep 3
done

# Запускаем основной процесс
exec "$@"
