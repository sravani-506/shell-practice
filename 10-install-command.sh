#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
 echo "ERROR:: please run this script with root access"
 exit 1 #give other than ) upto 127
else
echo "you are running with root access"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is not installed.. going to install it"
     dnf install mysql -y
     if [ $? -eq 0 ]
     then
         echo "Installing Mysql .. success"
     else
         echo "Installing Mysql .. Failed"
         exit 1
    fi
else 
    echo "MySQL is already installed... Nothing to do"
fi

# dnf install mysql -y

# if [ $? -eq 0 ]
# then
#     echo "Installing Mysql .. success"
# else
#    echo "Installing Mysql .. Failed"
#    exit 1
# fi

