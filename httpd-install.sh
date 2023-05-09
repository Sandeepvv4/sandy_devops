#!/bin/bash

# Install httpd package
sudo yum -y update
sudo yum -y install httpd

# Start httpd service
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

# Create index.html file
sudo echo "<html><body><h1>Hello, World Welcome, This is my new application!</h1></body></html>" | sudo tee /var/www/html/index.html

# Restart httpd service
sudo systemctl restart httpd.service

# Configure firewall to allow HTTP traffic
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
