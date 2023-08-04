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
echo b # it will print just 'a'
echo $b # it will print the value of a .: 10
echp ${b} #echo $b and echo ${b} both are same using the flower brackets is preferable