#!/bin/bash 

# Validate the user who is running the script is a root user or not.


COMPONENT=rabbitmq
source components/common.sh

echo -e "\e[35m Configuring ${COMPONENT} ......! \e[0m \n"

echo -n "Configuring ${COMPONENT} repo :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash          &>> ${LOGFILE}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>> ${LOGFILE}
stat $? 

echo -n "Installing ${COMPONENT} :"
yum install rabbitmq-server -y  &>> ${LOGFILE} 
stat $?

echo -n starting ${COMPONENT} :
systemctl enable rabbitmq-server &>> ${LOGFILE} 
systemctl start rabbitmq-server &>> ${LOGFILE} 

echo -n Creating ${COMPONENT} user account : 
rabbitmqctl add_user roboshop roboshop123 &>> ${LOGFILE} 
stat $?

echo -n configuring the permisions : 
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?

echo -e "\e[35m ${COMPONENT} Installation Is Completed \e[0m \n"