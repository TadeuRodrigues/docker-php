FROM php:7.0.26-fpm

# Updating and installing some dependences
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    libmcrypt-dev libxslt-dev libicu-dev libmemcached-dev zlib1g-dev \
    libmagickwand-dev libmagickcore-dev git && \
# Clear cache
    apt-get clean && \
    apt-get purge -y --auto-remove

# Installing Magento PHP extensions requirements
RUN docker-php-ext-install bcmath \
    mcrypt \
    pdo_mysql \
    xsl \
    intl \
    zip \
    soap \
    opcache

# Installing GD alone because it needs some configurations
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-source delete

# Installing pecl PHP modules
RUN pecl install memcached \
    xdebug-2.5.5 \
    imagick-3.4.3 && \
    docker-php-ext-enable memcached \
    xdebug \
    imagick

# Installing NodeJS from external resource
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
#Installing Grunt
    npm install -g grunt-cli & \
# Install composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
# Set www-data as owner for /var/www
    chown -R www-data:www-data /var/www/ && \
    chmod -R g+w /var/www/