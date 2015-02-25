#!/bin/bash

VDRBOX_FOLDER="vdrbox"

# detect if there is an instance of vdr opened
if ps aux | grep "[.]/vdr" > /dev/null
then
    # close vdr instance
    "$VDRBOX_FOLDER/vdr-stop.sh"
    sleep 4
    # retry
    "$VDRBOX_FOLDER/vdr-stop.sh"
else
    #start new vdr instance
    "$VDRBOX_FOLDER/vdr-start.sh"
fi
