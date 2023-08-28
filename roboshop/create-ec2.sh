#!/bin/bash

# To create a server, what all information needed 
# 1) AMI ID 

# 2) Type of instance 

# 3 ) Security Group

# 4) Instances you needed

# 5) DNS Record : Hosted Zone ID 
#!/bin/bash

COMPONENT=$1
ENV=$2

if [ -z $COMPONENT ] || [ -z $ENV ]; then 
    echo -e "\e[31m Component name and environment needed \e[0m"
    echo -e "\e[35m Example usage: - \n\t\e[0m sudo bash launch-ec2 <component> <environment>"
    exit 1
fi

AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7-Backup" | jq -r ".Images[].ImageId")" 
INSTANCE_TYPE="t3.micro"
HOSTEDZONE_ID="Z09543702TR3R8XKVSHJQ"
SECURITY_GROUP="$(aws ec2 describe-security-groups --filters Name=group-name,Values=RoboShopAllowAll | jq -r '.SecurityGroups[].GroupId')"
echo "${SECURITY_GROUP}"

create_ec2() {
    echo -e "****** Creating \e[35m ${COMPONENT} \e[0m Server Is In Progress ************** "

    PRIVATE_IP=$(aws ec2 run-instances --image-id "${AMI_ID}" --instance-type "${INSTANCE_TYPE}" --security-group-ids "${SECURITY_GROUP}" --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq -r '.Instances[0].PrivateIpAddress') 
    echo "$PRIVATE_IP"
    echo -e "Creating DNS of \e[31m ${COMPONENT} \e[0m ..."

    sed -e "s/COMPONENT/${COMPONENT}-${ENV}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/r53.json 

    aws route53 change-resource-record-sets --hosted-zone-id "$HOSTEDZONE_ID" --change-batch "file:///tmp/r53.json"

    echo -e "\e[35m Private IP address of ${COMPONENT}-${ENV} is created and ready to use \e[0m"
}

if [ "$COMPONENT" == "all" ]; then 
    for component in mongodb catalogue cart user shipping frontend payment mysql redis rabbitmq; do 
        COMPONENT="$component" 
        create_ec2
    done 
else 
    create_ec2 
fi 
