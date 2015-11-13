FROM atsu666/ioncube:5.5
MAINTAINER atsu666

# Set Locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install unzip
RUN apt-get -y install unzip

# Download a-blog cms
RUN chmod 777 /var/www/html && \
    cd /var/www/html && \
    wget http://ablogc.ms/1PPdqqC -O acms.zip && \
    unzip acms.zip && \
    mv acms2512_install/ablogcms/* ./ && \
    mv htaccess.txt .htaccess && \
    chmod -R 777 config.server.php archives archives_rev media setup themes && \
    rm index.html && \
    rm acms.zip && \
    rm -rf acms170

ADD db_default.php /var/www/html/setup/lib/db_default.php

# Run
ADD run.sh run.sh
RUN chmod 755 /*.sh

EXPOSE 80
CMD ["./run.sh"]
