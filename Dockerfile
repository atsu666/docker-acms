FROM ubuntu:latest
MAINTAINER atsu666

RUN apt-get update

# Install apache
RUN apt-get -y install apache2
RUN /usr/sbin/a2enmod rewrite
ADD apache.conf apache.conf
RUN cat apache.conf >> /etc/apache2/sites-available/000-default.conf && \
    rm apache.conf

# Install php
RUN apt-get -y install libapache2-mod-php5 php5-mysql php5-gd

# Install git
RUN apt-get -y install git

# Install etc
RUN apt-get -y install wget

# Download a-blog cms
RUN chmod 777 /var/www/html && \
    cd /var/www/html/ && rm ./index.html && \
    git clone https://github.com/appleple/ablogcms-package.git && \
    cd ablogcms-package && \
    git checkout --track origin/php55/latest && \
    cd ..
    
RUN cd /var/www/html && \
    cp ./ablogcms-package/ablogcms/license.php ./license.php && \
    cp ./ablogcms-package/ablogcms/config.server.php ./config.server.php && \
    cp ./ablogcms-package/ablogcms/htaccess.txt ./.htaccess && \
    cp -r ./ablogcms-package/ablogcms/setup ./setup && \
    cp -r ./ablogcms-package/ablogcms/archives ./archives && \
    cp -r ./ablogcms-package/ablogcms/archives_rev ./archives_rev && \
    cp -r ./ablogcms-package/ablogcms/media ./media && \
    cp -r ./ablogcms-package/ablogcms/themes ./themes && \
    rm -rf ./themes/system && \
    ln -s ./ablogcms-package/ablogcms/index.php ./index.php && \
    ln -s ./ablogcms-package/ablogcms/index.js ./index.js && \
    ln -s ./ablogcms-package/ablogcms/js ./js && \
    ln -s ./ablogcms-package/ablogcms/php ./php && \
    ln -s ./ablogcms-package/ablogcms/private ./private && \
    ln -s ../ablogcms-package/ablogcms/themes/system ./themes/system && \
    chmod -R 777 config.server.php archives archives_rev media setup themes

ADD db_default.php /var/www/html/setup/lib/db_default.php
    
# Download ioncube loader
RUN cd /var/www/html && \
    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar zxvf ioncube_loaders_lin_x86-64.tar.gz && \
    rm ioncube_loaders_lin_x86-64.tar.gz && \
    echo "zend_extension = /var/www/html/ioncube/ioncube_loader_lin_5.5.so" > /etc/php5/apache2/php.ini && \
    echo "session.gc_probability = 0" >> /etc/php5/apache2/php.ini

# Run
ADD run.sh run.sh
RUN chmod 755 /*.sh

EXPOSE 80
CMD ["./run.sh"]