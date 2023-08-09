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
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ] ; then # root user id is always 0 
    echo -e "\e[32m Script is expected to execute by the root user or with a sudo privilege. \e[0m\nExample: \n\t sudo bash wrapper.sh"
    exit 1
fi

echo -e "\e[35m Configuring frontend..... \e[0m]"
echo -n "Installing Nginx : "  #Here we are using -n because after printing this line the cusor dont go to next line 
yum install nginx -y &>> /tmp/frontend.log  # This command is push the output to frontend.log file

if [ $? -eq 0 ]; then
    echo -e "\e[32m Success \e[0m]"
else 
    echo -e "\e[31m Failure \e[0m]"
fi
echoho -n " Starting Nginx : "
$(systmctl start nginx)
if [ $? -eq 0 ]; then
    echo -e "\e[32m Success \e[0m]"
else 
    echo -e "\e[31m Failure \e[0m]"
fi
