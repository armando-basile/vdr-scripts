#!/bin/bash

# Script for VDR stop
# rel. 0.1.0

VDRBOX_FOLDER="vdrbox"

cd "/$VDRBOX_FOLDER"

killall vdr

# stop oscam server
#oscam-stop
#sleep 1


