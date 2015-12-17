FROM    debian:jessie

MAINTAINER Jan <jan@pronovix.com>

# Switch to de.debian.org
ADD ./sources.list /etc/apt/sources.list

# Upgrade debian packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl  
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ssh git screen mc nano wget curl pwgen vim-tiny python-setuptools \
	apache2 mysql-server libapache2-mod-php5 php5-mysql php-apc php5-gd php5-curl php5-memcache memcached
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean

# Configuration changes
RUN sed -i -e '163,169s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN sed -i -e "s/Timeout\s*=\s*300/Timeout = 3600/g" /etc/apache2/apache2.conf
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 2G/g" /etc/php5/apache2/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 2G/g" /etc/php5/apache2/php.ini
RUN sed -i -e "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
RUN a2enmod rewrite vhost_alias

# Install Drush
RUN wget http://files.drush.org/drush.phar
RUN php drush.phar core-status
RUN chmod +x drush.phar
RUN mv drush.phar /usr/local/bin/drush
RUN drush init

# Set up supervisor
RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
RUN chmod 755 /start.sh /etc/apache2/foreground.sh

EXPOSE 22 80 3306 9001

CMD ["/bin/bash", "-c", "screen /start.sh"]
