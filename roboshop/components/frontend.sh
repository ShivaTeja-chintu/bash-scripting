#!bin/bash
# 01-frontend
<<comment
The frontend is the service in RobotShop to serve the web content over Nginx.

Install Nginx.

```

# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx

```

Let's download the HTDOCS content and deploy it under the Nginx path.

```
# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

```

Deploy in Nginx Default Location.

```
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

```

- Finally, restart the service once to effect the changes.
- Now, you should be able to access the ROBOSHOP e-commerce webpage as shown below
comment

# installing  Nginx
#Validate the user who is running the script Is a root user or not
USER_ID = $(id -u)
if [ $USER_ID -ne 0 ] ; then # root user id is always 0 
    echo -e "\e[32m Script is expected to execute by the root user or with a pseudo privilege. \e[0m\n\nExample: \n\t\t sudo bash wrapper.sh"
    exit 1
fi

echo "Configuring frontend"
yum install nginx -y 