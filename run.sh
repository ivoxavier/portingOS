#!/bin/bash

function create_settings_file {
  touch .settings.txt
  echo "is_configured=false" >> .settings.txt
}

function show_supported_mobile_system {
  while read systems; do
  echo "**" $systems "**"
  done < "supported_mobile_system.txt"
}


source .settings.txt || echo "settings file not found"

if [[ -f .settings.txt && $is_configured == true ]]; 
then
    echo "**Initializing portingOS**"
    #init docker container with access to usb ports
    docker run -t -i --privileged -v /dev/bus/usb:/dev/bus/usb portingos bash || echo "Container was removed. Run: rm .settings.txt "
else 
    create_settings_file
    echo "** Welcome to portingOS** "
    echo ""
    echo "Select one of the systems typing his name."
    show_supported_mobile_system
    echo ""
    echo -n "Target System: "; read option
    #build image with the target system as argument
    docker build --build-arg target_system=$option -t portingos .
    > .settings.txt
    echo "is_configured=true" >> .settings.txt
    docker run -t -i --privileged -v /dev/bus/usb:/dev/bus/usb portingos bash
fi
