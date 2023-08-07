#!/bin/bash

# trying to execute the following with double quots 
echo The current process ID is :        "$$"
echo The exit code of last command is : "$?"
echo The given arguments count is  :    "$#"
echo The given arguments are :          "$*"
echo The given arguments are :          "$@"
# ------------------------------------------
# out put 
# -------


# trying to execute the following with single quots
echo The current process ID is :        '$$'
echo The exit code of last command is : '$?'
echo The given arguments count is  :    '$#'
echo The given arguments are :          '$*'
echo The given arguments are :          '$@'
