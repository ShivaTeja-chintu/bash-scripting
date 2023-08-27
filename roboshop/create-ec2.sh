#!/bin/bash

# To create a server, what all information needed 
# 1) AMI ID 

# 2) Type of instance 

# 3 ) Security Group

# 4) Instances you needed

# 5) DNS Record : Hosted Zone ID 
COMPONENT=$1
if [ -z $1 ]; then 
    echo -e "\e[31m component name needed \e[0m"
    echo -e "\e[35mExample usage : - \n\t\e[0m sudo bash launch-ec2"
    exit 1
fi
AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7-Backup"| jq ".Images[].ImageId" | sed -e 's/"//g')" 
INSTANCEE_TYPE="t3.micro"
SECURITY_GROUP=SG_ID="$(aws ec2 describe-security-groups  --filters Name=group-name,Values=RoboShopAllowAll | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')"     
PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCEE_TYPE} --security-group-ids ${SECURITY_GROUP} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT} ${ENV}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g' ) 

echo Private IP address of ec2 is : ${PRIVATE_IP}