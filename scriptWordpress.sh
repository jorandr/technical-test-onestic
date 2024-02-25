#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
newgrp docker
mkdir /here
docker run -d --name wordpress-db --mount source=wordpress-db,target=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=wordpress -e MYSQL_USER=manager -e MYSQL_PASSWORD=secret mariadb:10.3.9
mkdir -p ~/Sites/wordpress/target && cd ~/Sites/wordpress
docker run -d --name wordpress --link wordpress-db:mysql --mount type=bind,source="$(pwd)"/target,target=/var/www/html -e WORDPRESS_DB_USER=manager -e WORDPRESS_DB_PASSWORD=secret -p 8080:80 wordpress:4.9.8