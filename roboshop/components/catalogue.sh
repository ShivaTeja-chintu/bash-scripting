#!bin/bash

component=catalogue
LogFile=/tmp/${component}.log
AppUser="roboshop"
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

echo -e "\e[35m Configuring ${component} \e[0m" 
echo -e -n "Configuring ${component} Repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${LogFile}
status $?


echo -n Installing NodeJS :
yum install nodejs -y &>> ${LogFile}
status $?

id ${AppUser}
if [ $? -ne 0 ] ; then
    echo -n creating Application User Account :
    useradd roboshop
    echo -e "\e[32m Success \e[0m"
else
    echo -n User account already exists : 
    echo -e "\e[32m Success \e[0m"
fi





















# curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
# yum install nodejs -y
