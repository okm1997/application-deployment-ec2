#!/bin/bash

# Debug: List files in /tmp/nginx/
echo "Contents of /tmp/nginx/:"
ls -l /tmp/nginx/

# Check if the destination file exists and back it up if necessary
if [ -f /etc/nginx/nginx.conf ]; then
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
fi

# Overwrite nginx.conf
mv /tmp/nginx/nginx.conf /etc/nginx/nginx.conf

# Check if the destination index.html exists and back it up if necessary
if [ -f /usr/share/nginx/html/index.html ]; then
    mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak
fi

# Overwrite index.html
mv /tmp/nginx/index.html /usr/share/nginx/html/index.html

sudo systemctl start nginx