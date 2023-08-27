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
AMI_ID="ami-0e9fc91dd15aae68b"
INSTANCEE_TYPE="t3.micro"
SECURITY_GROUP="sg-05dd1814fb94730c8"
PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCEE_TYPE} --security-group-ids ${SECURITY_GROUP} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT} ${ENV}}]" | jq '.Instances[].PrivateIpAddress' )
echo Private IP address of ec2 is : ${PRIVATE_IP}