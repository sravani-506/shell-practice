#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e[0m"

logs_folder="/var/log/shellscript-logs"
script_name=$(echo $0 | cut -d "." -f1)
log_file="$logs_folder/$script_name.log"
PACKAGES=("mysql" "nginx")

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

#for PACKAGES in ${PACKAGES[@]}
for PACKAGES in $@
do 

    dnf list installed $PACKAGES &>>$log_file

    #check already installed or not. If installed $? value is 0, then
    # If not installed $? is not 0. expresion is true
    if [ $? -ne 0 ]
    then
        echo "$PACKAGES is not installed.. going to install it" | tee -a $log_file
        dnf install $PACKAGES -y &>>$log_file
        VALIDATE $? "$PACKAGES"
    else 
        echo -e "$y $PACKAGES is already installed $N... Nothing to do" | tee -a $log_file
    fi
done

