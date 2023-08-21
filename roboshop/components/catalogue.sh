#!/bin/bash 

COMPONENT=catalogue

# This is how we import the functions that are declared in a different file using source 
source components/common.sh
NODEJS                       # calling nodejs function.

echo -e "\n \e[35m ${COMPONENT} Installation Is Completed \e[0m \n"