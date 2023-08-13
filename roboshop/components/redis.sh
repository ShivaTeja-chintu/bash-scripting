#!bin/bash
component=redis
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

echo -e "\e[35m Configuring ${component} \e[0m" 
echo -e -n "Configuring ${component} Repo : "
curl -L https://raw.githubusercontent.com/stans-robot-project/${component}/main/${component}.repo -o /etc/yum.repos.d/${component}.repo &>> {LogFile}
status $?

echo -n Installing ${component} :
yum install ${component}-6.2.12 -y &>> ${LogFile}
status $?

echo -n Enabling the ${component} visibility :
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/${component}.conf
status $?

echo -n daemon-reloading the ${component} :
systemctl daemon-reload 
status $?
echo -n restarting the ${component} : 
systemctl restart ${component}
status $?

# echo -n Starting ${component} :
# systemctl enable ${component} &>> {LogFile}
# systemctl start ${component} &>> {LogFile}
# status $?


# echo -n downloading the schema : 
# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
# status $?

# echo -n Extracting the ${component} schema : 
# cd /tmp
# unzip -o ${component}.zip &>> {LogFile} # Here -O represents overwright
# status $?

# echo -n Injecting the ${component} schema :
# cd ${component}-main
# mongo < catalogue.js &>> {LogFile}
# mongo < users.js &>> {LogFile}
# status $?
echo -e "\e[35m Installation of ${component} is completed \e[0m"