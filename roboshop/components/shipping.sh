#!bin/bash 

COMPONENT=shipping

# This is how we import the functions that are declared in a different file using source 
source components/common.sh
JAVA                     # calling JAVA function.

echo -e "\n \e[35m ${COMPONENT} Installation Is Completed \e[0m \n"