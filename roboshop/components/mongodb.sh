#!bin/bash
component=mongodb
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
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
status $?

echo -n Installing ${component} :
yum install -y mongodb-org &>> ${LogFile}
status $?

echo -n Enabling the ${component} visibility :
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
status $?

echo -n restarting the ${component} : 
systemctl restart mongod
status $?

echo -n downloading the scheema : 
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
status $?

echo -n Starting ${component} :
systemctl enable mongod &>> {LogFile}
systemctl start mongod &>> {LogFile}
status $?

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js