FROM php:5.6.34-fpm-alpine

RUN apk update && \
    apk upgrade

RUN apk add libpng-dev libjpeg-turbo-dev freetype-dev php5-soap libxml2-dev libmcrypt-dev

RUN docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ \
           --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd soap mysql mysqli pdo_mysql mcrypt

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk --no-cache add shadow

RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
# Set www-data as owner for /var/www
    chown -R www-data:www-data /var/www/ && \
    chmod -R g+w /var/www/

RUN rm -rf /var/cache/apk/*
