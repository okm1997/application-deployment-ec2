#!/bin/bash

# Update the system
sudo dnf update -y

# Install and start NGINX
echo "Installing NGINX..."
sudo dnf install nginx -y
if [ $? -eq 0 ]; then
  echo "NGINX installed successfully."
  sudo systemctl enable nginx
  sudo systemctl start nginx
else
  echo "Failed to install NGINX." >&2
fi

# Install Ruby and wget
echo "Installing Ruby and wget..."
sudo dnf install -y ruby wget
if [ $? -eq 0 ]; then
  echo "Ruby and wget installed successfully."
else
  echo "Failed to install Ruby and wget." >&2
fi

# Install CodeDeploy agent
echo "Installing CodeDeploy agent..."
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
./install auto
if [ $? -eq 0 ]; then
  echo "CodeDeploy agent installed successfully."
  sudo service codedeploy-agent start
else
  echo "Failed to install CodeDeploy agent." >&2
fi