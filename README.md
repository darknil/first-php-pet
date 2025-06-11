# Laravel 12.18.0 Dockerization


## How to run

Run command:
```
docker-compose up -d
docker-compose exec app composer install --no-interaction --prefer-dist --optimize-autoloader
```
This will start your Docker containers in detached mode (`up -d`) and then install all PHP dependencies inside the `app` container using Composer. 

After these steps, you will have a running Laravel application inside Docker, with all required packages installed, ready for development or testing.
