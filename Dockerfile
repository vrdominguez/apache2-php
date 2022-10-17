FROM debian:bullseye
MAINTAINER victor@vrdominguez.es

EXPOSE 80

# Install apache
RUN apt-get update && apt-get dist-upgrade -y \
		&& apt-get install -y --no-install-recommends ca-certificates apache2 php libapache2-mod-php php-mongodb \
		                                              php-gd php-mysql php-xml php-pear php-soap php-ldap \
		&& apt-get clean \
		&& a2enmod rewrite \
		&& sed -i -e 's:${APACHE_LOG_DIR}/access.log:/dev/stdout:' -e 's:${APACHE_LOG_DIR}/error.log:/dev/stderr:' /etc/apache2/sites-available/*

# Install composer
RUN apt-get install -y --no-install-recommends curl \
		&& curl -sS https://getcomposer.org/installer | php \
		&& mv composer.phar /usr/bin/composer \
		&& chmod a+x /usr/bin/composer \
		&& apt-get remove -y curl --purge \
		&& apt-get autoremove -y \
		&& apt-get clean

ENTRYPOINT ["/usr/sbin/apache2ctl", "-e", "info", "-DFOREGROUND"]
