# Moodle 3.9.17 (terdeteksi dari core_config: 2020061517.01) + PHP 7.4
FROM php:7.4-apache

ARG MOODLE_TAG=v3.9.17

RUN apt-get update && apt-get install -y --no-install-recommends \
      git unzip libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libicu-dev \
      libxml2-dev libpq-dev libonig-dev libsodium-dev \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" gd intl mysqli pdo_mysql zip soap opcache exif sodium \
 && a2enmod rewrite \
 && rm -rf /var/lib/apt/lists/*

RUN { echo 'max_input_vars=5000'; echo 'upload_max_filesize=256M'; echo 'post_max_size=256M'; \
      echo 'memory_limit=512M'; } > /usr/local/etc/php/conf.d/moodle.ini

# Source Moodle versi persis
RUN git clone --depth 1 --branch ${MOODLE_TAG} https://github.com/moodle/moodle.git /var/www/html \
 && rm -rf /var/www/html/.git

# Theme Moove (versi di data: 3.9.08). Cek compat; tag bisa disesuaikan.
ARG MOOVE_REF=MOODLE_39_STABLE
RUN git clone --depth 1 --branch ${MOOVE_REF} https://github.com/willianmano/moodle-theme_moove.git /var/www/html/theme/moove \
 && rm -rf /var/www/html/theme/moove/.git

COPY config.php /var/www/html/config.php
RUN mkdir -p /var/www/moodledata && chown -R www-data:www-data /var/www/html /var/www/moodledata
EXPOSE 80
