#!bin/bash
# 01-${component}
set -e # Enable immediate exit on error We need to use this command in every beginning of the script file
<<comment
The ${component} is the service in RobotShop to serve the web content over Nginx.

Install Nginx.

```

# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx

```

Let's download the HTDOCS content and deploy it under the Nginx path.

```
# curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/${component}/archive/main.zip"

```

Deploy in Nginx Default Location.

```
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/${component}.zip
# mv ${component}-main/* .
# mv static/* .
# rm -rf ${component}-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

```

- Finally, restart the service once to effect the changes.
- Now, you should be able to access the ROBOSHOP e-commerce webpage as shown below

comment
######################## Lets start the code ####################################
component=frontend
LogFile=/tmp/${component}.log
status(){
    if [ $1 -eq 0 ]; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi
}

# installing  Nginx
#Validate the user who is running the script Is a root user or not
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ] ; then # root user id is always 0 
    echo -e "\e[32m Script is expected to execute by the root user or with a sudo privilege. \e[0m\nExample: \n\t sudo bash wrapper.sh"
    exit 1
fi

echo -e "\e[35m Configuring ${component}..... \e[0m"


echo -n "Installing Nginx : "  #Here we are using -n because after printing this line the cusor dont go to next line 
yum install nginx -y &>> ${LogFile}  # This command is push the output to ${component}.log file
status $? #We are calling the status function and passing $? as an argumentt

echo -n "Enabling Nginx :"
systemctl enable nginx &>> ${LogFile}
status $?

echo -n " Starting Nginx : "
systemctl start nginx
status $?

echo -n "Downloading the ${component} Component :"
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/${component}/archive/main.zip"
status $?

echo -n "Cleaning up of ${component} : "
cd /usr/share/nginx/html 
rm -rf * &>> ${LogFile}
status $?

echo -n "Unzipping the ${component}: "
unzip /tmp/${component}.zip  &>> ${LogFile}
status $?

echo -n "Sorting the ${component} files : "
mv ${component}-main/* .
mv static/* .
rm -rf static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
status $?

echo -n "Restarting the Nginx : "
systemctl daemon-reload
systemctl restart nginx
status $?
