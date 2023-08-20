# all the cmmon modules will be declared here 

LogFile=/tmp/${component}.log
AppUser=roboshop
USER_ID=$(id -u)


#Validate the user who is running the script Is a root user or not

if [ $USER_ID -ne 0 ] ; then # root user id is always 0 
    echo -e "\e[32m Script is expected to execute by the root user or with a sudo privilege. \e[0m\nExample: \n\t sudo bash wrapper.sh"
    exit 1
fi

status(){
    if [ $1 -eq 0 ]; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi
}

# Creating Roboshop account
Create_User()
{
    id ${AppUser} &>>${LogFile}

    if [ $? -ne 0 ] ; then
        echo -n creating Application User Account :
        useradd ${AppUser} &>> ${LogFile}
        echo -e "\e[32m Success \e[0m"
    else
        echo -n User account already exists : 
        echo -e "\e[32m Success \e[0m"
    fi
}

Download_and_Extract(){
    echo -n Downloading the ${component} :
    curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/${component}/archive/main.zip" &>> ${LogFile}
    status $?

    echo -n copying the ${component} to ${AppUser} home directory : 
    cd /home/${AppUser}/
    rm -rf ${component}
    unzip -o /tmp/${component}.zip &>> ${LogFile}
    status $?
    
    echo -n Changing the ownership in ${component} file : 
    mv ${component}-main ${component}
    chown -R ${AppUser}:${AppUser} /home/${AppUser}/${component}/
    status $?

}
CONFIG_SVC() {
echo -n "Configuring the ${COMPONENT} system file :"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/'  -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} service :"
systemctl daemon-reload &>> ${LOGFILE}
systemctl enable ${COMPONENT} &>> ${LOGFILE}
systemctl restart ${COMPONENT} &>> ${LOGFILE}
CONFIG_SVC
stat $?

}
# Declaring a NodeJs Function
NodeJS()
{
    echo -e "\e[35m Configuring ${component} \e[0m" 
    echo -e -n "Configuring ${component} Repo : "
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${LogFile}
    status $?


    echo -n Installing NodeJS :
    yum install nodejs -y &>> ${LogFile}
    status $?

    Create_User            # calling the create user function
    Download_and_Extract   # calling the Download and extract function 

    echo -n Genarating the ${component} Artifacts : 
    cd /home/${AppUser}/${component}
    npm install &>> ${LogFile}
    status $?
    

}