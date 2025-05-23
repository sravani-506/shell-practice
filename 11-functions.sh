#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
 echo "ERROR:: please run this script with root access"
 exit 1 #give other than ) upto 127
else
echo "you are running with root access"
fi

#validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
     then
         echo "Installing $2 .. success"
     else
         echo "Installing $2 .. Failed"
         exit 1
    fi
}


dnf list installed mysql

#check already installed or not. If installed $? value is 0, then
# If not installed $? is not 0. expresion is true
if [ $? -ne 0 ]
then
    echo "MySQL is not installed.. going to install it"
     dnf install mysql -y
     VALIDATE $? "MySQL"
else 
    echo "MySQL is already installed... Nothing to do"
fi


dnf list installed nginx

#check already installed or not. If installed $? value is 0, then
# If not installed $? is not 0. expresion is true
if [ $? -ne 0 ]
then
    echo "Mnginx is not installed.. going to install it"
     dnf install mysql -y
     VALIDATE $? "MySQL"
else 
    echo "nginx is already installed... Nothing to do"
fi
