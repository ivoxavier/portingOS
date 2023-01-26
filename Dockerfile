FROM ubuntu:latest

LABEL \ 
maintainer="ixsvf <Ivo Xavier>" \
description="portingOS is container that has all the dependencies to port an OS to a mobile device" \
"portingOS.version"="0.1.1-beta" 

#create argument to receive the target system
ARG target_system

#create folder to store the scripts and modules from portingOS
RUN mkdir /portingOS

#copy the scripts and modules from host to the container
COPY ./scripts_modules /portingOS/scripts_modules
COPY ./target_os_dependencies /portingOS/target_os_dependencies
COPY ./supported_mobile_system.txt /portingOS/supported_mobile_system.txt

#set the scripts and modules as executable
RUN chmod +x /portingOS/scripts_modules/*

#setup the portingOS for the target system
RUN if [ "$target_system" = "ubuntu_touch" ]; then \
    /portingOS/scripts_modules/ubuntu_touch_setup.sh; \
    /portingOS/scripts_modules/install_dependencies.sh $target_system; \
    else \ 
    echo "target system not supported"; \
    apt update && apt upgrade -y; fi

#android-tools-adb is needed to use adb if necessary, and not $target system specific
RUN apt install -y android-tools-adb