FROM debian:buster
label mantainer <igorporfirio94@gmail.com>
ENV TZ=America/Sao_Paulo

#Install necessary tools
RUN apt update && \
    apt -y upgrade && \
    apt install -y unzip apache2 apache2-utils libapache2-mod-php php php-mysql \
    php-cli php-pear php-gmp php-gd php-bcmath php-mbstring php-curl php-xml \
    php-zip wget mariadb-server mariadb-client nano && \
    apt clean all

RUN a2enmod rewrite

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz && \
    tar -vxzf phpMyAdmin-5.0.2-all-languages.tar.gz -C /usr/share/ && \
    mv /usr/share/phpMyAdmin-5.0.2-all-languages /usr/share/phpmyadmin

RUN mkdir /etc/phpmyadmin && \
    touch /etc/phpmyadmin/htpasswd.setup && \
    mkdir -p /var/lib/phpmyadmin/tmp && \
    chown www-data. /var/lib/phpmyadmin/ -R

COPY phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf

RUN a2enconf phpmyadmin

ADD config.inc.php /usr/share/phpmyadmin/config.inc.php

RUN cd /var/www/html && wget https://github.com/remontti/LogIPv6RouterOS/archive/master.zip &&\
    unzip master.zip &&\
    mv LogIPv6RouterOS-master logs6
    
RUN /etc/init.d/apache2 start && \ 
    /etc/init.d/mysql start
    
RUN mariadb -p && \
    CREATE DATABASE logs6; && \
    GRANT ALL PRIVILEGES ON logs6.* TO 'logs6'@'localhost' IDENTIFIED BY '@CmrapTHL841P3162'; \
    FLUSH PRIVILEGES;
    quit;
    

EXPOSE 80,3306

CMD ["/bin/bash"]
