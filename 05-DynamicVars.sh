#!/bin/bash

Date=$(date +%D) # Whenever you want to run an experssion you need to enclose them in paranthesis"()"

echo Today date is : "$Date" 

# To find how many active sessions are there we have to use the following code 
Session_count="$(who | wc -l)"
echo "current active sessions are : $Session_count"