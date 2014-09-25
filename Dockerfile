FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    supervisor \
    git \
    curl \
    nginx \
    php5-cli \
    php5-json \
    php5-json \
    php5-fpm \
    php5-intl \
    php5-mysqlnd

COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN echo "daemonize=no" > /etc/php5/fpm/pool.d/daemonize.conf
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD docker/vhost.conf /etc/nginx/sites-enabled/default
ADD docker/start.sh start.sh

ADD . /var/www

EXPOSE 80

ENTRYPOINT ["/start.sh"]
