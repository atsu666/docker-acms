#!/bin/bash

cd /var/www/html/setup/lib/
sed -i -e "s/MYSQL_PORT_3306_TCP_ADDR/$MYSQL_PORT_3306_TCP_ADDR/" db_default.php

/usr/sbin/apachectl -DFOREGROUND