#!bin/bash
#set -e # Enable immediate exit on error We need to use this command in every beginning of the script file
component=catalogue

source components/cpmmon.sh

NodeJS

echo -e "\e[35m Installation of ${component} is completed \e[0m"
