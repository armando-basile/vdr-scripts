#!/bin/bash

# Script for OSCAM start
# rel. 0.1.0

VDRBOX_FOLDER="vdrbox"

cd "/$VDRBOX_FOLDER"

# shure oscam isn't started 
./oscam-stop

sleep 2
/usr/local/bin/oscam --daemon --config-dir /etc/oscam

