#!/bin/bash

# special variables gives special properties to your variables 

# Here are few of the special variables : $0 -$9 ; $? ; $# ; $* ; $@

# To know the script which is executed so far we need to use the following bash script 

echo $0 # $0 will print ht escript you are executing 
echo "Executed script name is : $0"

# If we want to supply the arguments we should following script 
# in bash we can supply upto 9 arguments 
# syntax to suply the arguments -->  centos@WorkStation ~/bash-scripting ]$ bash 06-specialVariables Argument

echo "name of the recently launched rocket :$1"
echo "name of the recently launched rocket :$2"

# What if we supply more than 9 arguments 
# if we supply more than 9 argumants the 10th argument will replace the 1st one and this is called as pedaling


# echo $* --> it will print the passed arguments 
# echo $@ --> it will print the passed arguments [$* and $# both are same]
# echo $# -->
# echo $$ -->it is going to print the PID of the current process
# echo $? --> it is going to print the exit code of the last command 
echo The current process ID is : $$
echo The exit code of last command is : $?
echo The given arguments count is  : $#
echo The given arguments are : $*
echo The given arguments are : $@

