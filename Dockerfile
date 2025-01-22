FROM dunglas/frankenphp:php8.3

WORKDIR /app

RUN apt-get update && apt-get install  -y \
    git curl libpng-dev libjpeg-dev libfreetype6-dev \
    libpq-dev libonig-dev libzip-dev unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring zip gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/* 

# Install Composer
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

# Hanya saat development:
ENV SERVER_NAME=":7772"

# Expose port untuk HTTP/HTTPS
EXPOSE 7772 774 7773 9000

# Instal dependensi Laravel menggunakan Composer
# RUN composer install --no-dev --optimize-autoloader
