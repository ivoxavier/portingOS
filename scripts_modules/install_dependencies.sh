#!/bin/bash

#check if requirements are installed, if not, install them
function requirements {
echo -n " Status --> $1: "
if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo  "Requeriment Not Installed. Installing Now..."
  if [[ ! -z $2 ]]
  then
     apt -qq update
  fi
   apt -qq -y install $1;
else
  echo "Requeriment Already Installed!"                             
fi

}

#this script is called from inside the docker container
#and receives the target system as argument
while read line; do

requirements $line

done < "/portingOS/target_os_dependencies/"$1".txt"