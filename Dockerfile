FROM ubuntu:18.04
RUN apt update && apt upgrade -y
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
RUN apt-get install -y tzdata

RUN ln -fs /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt install -y \ 
        php \
        libapache2-mod-php \
        php-fpm \
        wget \ 
        php-cli \ 
        php-zip \ 
        unzip \
        curl \
        apache2 \ 
        mysql-server \ 
        php-mysql \
        php-curl \ 
        php-json \ 
        php-cgi

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# RUN systemctl restart apache2
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs php-xml
ADD composer.json /
RUN composer install
# RUN tasksel install lamp-server