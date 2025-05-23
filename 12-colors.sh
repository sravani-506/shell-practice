#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
 echo -e "$R ERROR:: please run this script with root access $N"
 exit 1 #give other than ) upto 127
else
echo "you are running with root access"
fi

#validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
     then
         echo -e "Installing $2 .. $G success $N"
     else
         echo -e "Installing $2 .. $R Failed $N"
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
    echo -e "$Y MySQL is already installed $N... Nothing to do"
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
    echo -e "$Y nginx is already installed $N... Nothing to do"
fi
