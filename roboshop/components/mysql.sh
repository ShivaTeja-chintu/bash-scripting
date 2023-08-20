#!/bin/bash 

COMPONENT=mysql

source components/common.sh

echo -e "\e[35m Configuring ${COMPONENT} ......! \e[0m \n"

echo -n "Configuring ${COMPONENT} repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing ${COMPONENT}  :"
yum install mysql-community-server -y     &>>  ${LOGFILE}
stat $?

echo -n "Starting ${COMPONENT}:" 
systemctl enable mysqld   &>>  ${LOGFILE}
systemctl start mysqld    &>>  ${LOGFILE}
stat $?

echo -n Extracting the password : 
default_root_password=$(sudo grep 'temporary password' /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $?


echo "show databases;" | mysql -uroot -pRoboShop@1 &>>  ${LOGFILE}
if [ $? -ne 0 ]; then 
    echo -n "Performing default password reset of root account:"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql  --connect-expired-password -uroot -p$default_root_password &>>  ${LOGFILE}
    stat $?
else 
    echo -n password reset already done : 
    stat $?
fi 

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password ${LOGFILE}
if [ $? -eq 0 ]; then
    echo -n uninstalling validate_password plugin : 
    echo "uninstall plugin validate_password" | mysql -uroot -pRoboShop@1 ${LOGFILE}
    stat $?
else 
     echo -n validate_password plugin uninstall already done : 
     stat$?
fi
