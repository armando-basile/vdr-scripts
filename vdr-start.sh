#!/bin/bash

# Script for VDR start
# rel. 0.1.0

VDRVER=2.2.0
VDRBOX_FOLDER="vdrbox"

# start oscam server
#cd "/$VDRBOX_FOLDER"
#oscam-start

cd "/$VDRBOX_FOLDER/vdr-$VDRVER"

./vdr -c /etc/vdr -E /var/vdr -l 3 -L PLUGINS/lib \
     -P'softhddevice -v vdpau -f' \
     -P skinnopacity \
     -P dvbapi \
     -P'tvguide -l /usr/local/share/vdr/plugins/skinnopacity/logos ' \
     -P femon \
     -P loadepg \
     -u root \
     -d

