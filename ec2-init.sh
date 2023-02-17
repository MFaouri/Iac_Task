#!bin/bash

#By default commands in user data gets executed with root user. Hence, "sudo su" command is optional. 
sudo su

yum install httpd -y
cd /var/www/html/
echo "<html><h1>Greetings from $(hostname) in $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</h1></html>" > index.html

service httpd start