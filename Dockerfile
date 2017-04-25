FROM debian:jessie
MAINTAINER victor@vrdominguez.es

EXPOSE 80

RUN apt-get update \
	&& apt-get install -y --no-install-recommends apache2 php5 libapache2-mod-php5 php5-gd php5-mysqlnd \
	&& apt-get clean \
	&& rm -rf /var/lib/apt /var/cache/apt /var/lib/dpkg \
	&& ln -sf /proc/self/fd/1 /var/log/apache2/access.log \
    	&& ln -sf /proc/self/fd/1 /var/log/apache2/error.log
	

ENTRYPOINT ["/usr/sbin/apache2ctl", "-e", "info", "-DFOREGROUND"]
