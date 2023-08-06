#!/bin/bash

# What is a variables???
# variables are genarally used to store values dynamically
a=10
b=20
c=xyz

# There is no concept of data types in linux shel scripting
# By default everything is a string 
# if your input or variables are having special charecters enclose them always in double quotes

# How can I print the value of a variable 
echo printing b # it will print just 'b'
echo printing the value of b : $b # it will print the value of b .: 20
echo printing the value of b  :${b} #echo $b and echo ${b} both are same using the flower brackets is preferable
echo "printing the value of x :${x}" # it dosen't print anything because we didn't declared the value of x

# Data_Dir = robot
# rm -rf data/Data_Dir --> it will delete the robot dir
# B U T what if :
# Data_Dir is not declared 
# rm -rf data/Data_Dir --> it will delete total data directory because Data_Dir is empty