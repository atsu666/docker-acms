docker-acms
===========

A Dockerfile that installs the latest a-blog cms.

## Installation

```
$ git clone https://github.com/atsu666/docker-acms.git
$ cd docker-acms
$ docker build --no-cache -t acms:latest .
$ docker pull mysql:latest
```

## Usage

```
$ docker run --name mysql-server -e MYSQL_ROOT_PASSWORD=root -d mysql
$ docker run --name acms --link mysql-server:mysql -it -p 80:80 acms:latest /bin/bash

$ docker run --name mysql-server -e MYSQL_ROOT_PASSWORD=root -d mysql
$ docker run --name acms --link mysql-server:mysql -v /home/core/share:/var/www/html -p 80:80 acms:latest

$ docker run -i -t -p 80:80 --name httpd ubuntu:latest /bin/bash
```