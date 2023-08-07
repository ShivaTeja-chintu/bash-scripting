#!/bin/bash

# there are 4 types of commands 

# 1) Binary         (/bin , /sbin)
# 2) Aliases        (Alises are shortcuts ,aliascnet="netstat -tulppn")
# shellBuilt-in commands 
#4)Functions        # Functions are nothing but a set of commands that can be written in sequence and can be called n number of times 

# How to declare a function ?

# f(){
#     echo hi 
# }
# # this is how we call a function
# f 
bye(){
    echo The given task was completed So Bye to you 
}
stat(){
    echo "The number of active sessions are : $(who | wc -l)"
    echo "Today's date is : $(date +%F)"
    bye # calling a function in a function

}
# calling the function 
stat
# out put
# The number of active sessions are : 1
# Today's date is : 2023-08-07

