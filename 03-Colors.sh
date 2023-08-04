#!/bin/bash
<<comment
Color	Foreground Code (Text)	Background Code
-------------------------------------------------
Black	        30	                   40
Red	            31	                   41
Green	        32	                   42
Yellow	        33	                   43
Blue	        34	                   44
Magenta	        35	                   45
Cyan	        36	                   46
comment
# Syntax to print the color --> echo -e \e[coloecodem your msg will be printed in color\e[0m
echo -e "\e[33m I am printing yellow color \e[0m"

# To print something with the background with foreground here is the syntax
# echo -e "\e[31m;36m I am printing this in cyan with red background \e[0m"
echo -e "\e[41;33m I am printing this in yello with red background \e[0m"