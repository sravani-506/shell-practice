#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e[0m"

logs_folder="/var/log/shellscript-logs"
script_name=$(echo $0 | cut -d "." -f1)
log_file="$logs_folder/$script_name.log"

mkdir -p $logs_folder
echo "Script started executing at: $(date)" | tee -a $log_file

if [ $USERID -ne 0 ]
then
 echo -e "$R ERROR:: please run this script with root access $N" | tee -a $log_file
 exit 1 #give other than ) upto 127
else
echo "you are running with root access" | tee -a $log_file
fi

#validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
     then
         echo -e "Installing $2 .. $G success $N" | tee -a $log_file
     else
         echo -e "Installing $2 .. $R Failed $N" | tee -a $log_file
         exit 1
    fi
}


dnf list installed mysql &>>$log_file

#check already installed or not. If installed $? value is 0, then
# If not installed $? is not 0. expresion is true
if [ $? -ne 0 ]
then
    echo "MySQL is not installed.. going to install it" | tee -a $log_file
     dnf install mysql -y &>>$log_file
     VALIDATE $? "MySQL"
else 
    echo -e "$y MySQL is already installed $N... Nothing to do" | tee -a $log_file
fi


dnf list installed nginx &>>$log_file

#check already installed or not. If installed $? value is 0, then
# If not installed $? is not 0. expresion is true
if [ $? -ne 0 ]
then
    echo "nginx is not installed.. going to install it" | tee -a $log_file
     dnf install nginx -y &>>$log_file
     VALIDATE $? "nginx"
else 
    echo -e "$y nginx is already installed $N... Nothing to do" | tee -a $log_file
fi
