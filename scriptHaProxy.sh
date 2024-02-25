#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
newgrp docker
sudo echo "global
        daemon
        maxconn 256

    defaults
        mode http
        timeout connect 5000ms
        timeout client 50000ms
        timeout server 50000ms

    listen http-in
        bind *:80
        server server1 10.0.1.10:8080 maxconn 32" > haproxy.cfg
sudo echo "FROM haproxy:2.3
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg" > Dockerfile
sudo docker build -t load-balancer-haproxy .
sudo docker run -d -p 80:80 --name load-balancer-haproxy --sysctl net.ipv4.ip_unprivileged_port_start=0 load-balancer-haproxy