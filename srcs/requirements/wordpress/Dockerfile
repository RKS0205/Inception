FROM debian:buster

RUN apt update

RUN apt install curl less mariadb-client redis php7.3 \
	php7.3-phar php7.3-json php7.3-curl php7.3-fpm php7.3-mysqli \
	php7.3-iconv zip unzip wget -y

RUN mkdir -p /var/run/php && chmod 777 /var/run/php

RUN echo "\nlisten = 0.0.0.0:9000\n" >>/etc/php/7.3/fpm/pool.d/www.conf

WORKDIR /tmp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod a+x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && wp cli update

RUN mkdir -p /var/www/wordpress

RUN wp core download --path=/var/www/wordpress --allow-root

COPY conf /var/www/wordpress

RUN echo "env[DB_HOST] = \$DB_HOST" >>/etc/php/7.3/fpm/pool.d/www.conf
RUN echo "env[DB_NAME] = \$DB_NAME" >>/etc/php/7.3/fpm/pool.d/www.conf
RUN echo "env[DB_USER] = \$DB_USER" >>/etc/php/7.3/fpm/pool.d/www.conf
RUN echo "env[DB_PASS_USER] = \$DB_PASS_USER" >>/etc/php/7.3/fpm/pool.d/www.conf
RUN echo "env[DOMAIN_NAME] = \$DOMAIN_NAME" >>/etc/php/7.3/fpm/pool.d/www.conf

COPY tools /usr/local/bin

RUN chmod a+x /usr/local/bin/setup.sh

EXPOSE 9000

ENTRYPOINT ["setup.sh"]