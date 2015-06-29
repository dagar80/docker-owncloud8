FROM php:5-apache

MAINTAINER David Garcia <dagar80@gmail.com>

RUN apt-get update && apt-get install -y \
php5-gd \
php5-json \
php5-mysql \
php5-pgsql \
php5-sqlite \
php5-curl \
wget \
bzip2
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/
RUN wget https://download.owncloud.org/community/owncloud-8.0.2.tar.bz2
RUN tar -xjf owncloud-8.0.2.tar.bz2
RUN chown -R www-data:www-data /var/www && rm owncloud-8.0.2.tar.bz2

ADD owncloud.conf /etc/apache2/conf-available/owncloud.conf
RUN ln -s /etc/apache2/conf-available/owncloud.conf /etc/apache2/conf-enabled/owncloud.conf
RUN a2enmod rewrite

EXPOSE 443
EXPOSE 80
