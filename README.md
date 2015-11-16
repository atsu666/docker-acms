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
$ docker run --name acms --link mysql-server:mysql -d -p 80:80 atsu666/acms:latest
```
