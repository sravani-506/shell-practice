#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
 echo "ERROR:: please run this script with root access"
 exit 1 #give other than ) upto 127
else
echo "you are running with root access"
fi

dnf install mysqlghtu -y

if [ $? -eq 0 ]
then
    echo "Installing Mysql .. success"
else
   echo "Installing Mysql .. Failed"
fi

