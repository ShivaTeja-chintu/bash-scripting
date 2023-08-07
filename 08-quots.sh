#!/bin/bash

# trying to execute the following with double quots 
echo The current process ID is :        "$$"
echo The exit code of last command is : "$?"
echo The given arguments count is  :    "$#"
echo The given arguments are :          "$*"
echo The given arguments are :          "$@"
# ------------------------------------------
# out put
# -------- 
# The current process ID is        : 1623
# The exit code of last command is : 0
# The given arguments count is     : 0
# The given arguments are          : 
# The given arguments are          :

# -------


# trying to execute the following with single quots
echo The current process ID is :        '$$'
echo The exit code of last command is : '$?'
echo The given arguments count is  :    '$#'
echo The given arguments are :          '$*'
echo The given arguments are :          '$@'
# output
# -------
# The current process ID is :             $$
# The exit code of last command is :      $?
# The given arguments count is :          $#
# The given arguments are :               $*
# The given arguments are :               $@

# Single quots will supress the power of special variables 
# whenever you are executing anty special vriables preffer to avoid single quots 

