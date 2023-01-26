#!/bin/bash


function halium_versions() {
    git ls-remote --heads https://github.com/Halium/android | awk '{print $2}' | sed 's/refs\/heads\///g' | sort -V
}


echo "It's recommended to port for a Halium version >= 7.1."
echo "For more information, see https://docs.ubports.com/en/latest/porting/introduction/Intro.html"
echo ""
echo "Choose from the ones available:"

select version_to_port in $(halium_versions); do
    echo "You chose $version_to_port"

    # Sleep for 3 seconds to give the user time to cancel the script.
    sleep 3
    
    # Create a directory for the Halium project.
    echo ""
    echo "Creating directory for Halium in /home/halium..."
    echo ""
    cd /home/
    mkdir halium && cd halium

    # Initialize the correct version of Halium.

    echo "Initializing repo..."
    repo init -u https://github.com/Halium/android -b $version_to_port --depth=1
    
    # Download the code of the Halium project for your device.
    repo sync -c -j 16

    break
done
