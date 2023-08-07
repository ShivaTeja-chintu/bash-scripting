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

stat(){
    echo The number of active sessions are : $(who | wc -l)
    echo Today's date i s : $(date+%F)

}

stat