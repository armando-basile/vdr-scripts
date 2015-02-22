#!/bin/bash

# Script to install libraries and config files after build of VDR
# rel. 0.1.0

VDRVER=2.2.0
VDRBOX_FOLDER="vdrbox"
VDRSRC="/$VDRBOX_FOLDER/vdr-$VDRVER/PLUGINS/src"
VDRLIB="/$VDRBOX_FOLDER/vdr-$VDRVER/PLUGINS/lib"
VDRMAIN="/$VDRBOX_FOLDER/vdr-$VDRVER"
PREVDIR=`pwd`

# dvb api plugin to manage oscam and softcam
echo "copying libvdr-dvbapi.so.$VDRVER"
cp -f "$VDRSRC/dvbapi/libvdr-dvbapi.so" "$VDRLIB/libvdr-dvbapi.so.$VDRVER"

# standard vdr plugins
echo "copying libvdr-epgtableid0.so.$VDRVER"
cp -f "$VDRSRC/epgtableid0/libvdr-epgtableid0.so" "$VDRLIB/libvdr-epgtableid0.so.$VDRVER"

# info about signal
echo "copying libvdr-femon.so.$VDRVER"
cp -f "$VDRSRC/femon/libvdr-femon.so" "$VDRLIB/libvdr-femon.so.$VDRVER"

# update epg
echo "copying libvdr-loadepg.so.$VDRVER"
cp -f "$VDRSRC/loadepg/libvdr-loadepg.so" "$VDRLIB/libvdr-loadepg.so.$VDRVER"

# video manage
echo "copying libvdr-softhddevice.so.$VDRVER"
cp -f "$VDRSRC/softhddevice/libvdr-softhddevice.so" "$VDRLIB/libvdr-softhddevice.so.$VDRVER"

# show epg interface
echo "copying libvdr-tvguide.so.$VDRVER"
cp -f "$VDRSRC/tvguide/libvdr-tvguide.so" "$VDRLIB/libvdr-tvguide.so.$VDRVER"

# skin nOpacity
echo "copying libvdr-skinnopacity.so.$VDRVER"
cp -f "$VDRSRC/skinnopacity/libvdr-skinnopacity.so" "$VDRLIB/libvdr-skinnopacity.so.$VDRVER"

# skin flatplus
echo "copying libvdr-skinflatplus.so.$VDRVER"
cp -f "$VDRSRC/skinflatplus/libvdr-skinflatplus.so" "$VDRLIB/libvdr-skinflatplus.so.$VDRVER"

# copy icons, themes, config files and logos
echo "copying skin nopacity icons"
cp -rf "$VDRSRC/skinnopacity/icons" /usr/local/share/vdr/plugins/skinnopacity/
echo "copying skin nopacity themes"
cp -f "$VDRSRC/skinnopacity/themes/*" /etc/vdr/themes/
echo "copying skin nopacity themes config files"
cp -f "$VDRSRC/skinnopacity/conf/*" /etc/vdr/plugins/skinnopacity/themeconfigs/

echo "copying tvguide icons"
cp -rf "$VDRSRC/tvguide/icons" /usr/local/share/vdr/plugins/tvguide/
echo "copying tvguide themes"
cp -f "$VDRSRC/tvguide/themes/*" /etc/vdr/themes/

# loadepg config files
echo "copying loadepg config files"
cp -f "$VDRSRC/loadepg/conf/*" /etc/vdr/plugins/loadepg/

# copy default vdr config files
echo "copying vdr default config files"
cp -f "$VDRMAIN/keymacros.conf" /etc/vdr/
cp -f "$VDRMAIN/sources.conf" /etc/vdr/
cp -f "$VDRMAIN/setup.conf" /etc/vdr/

# update setup.conf for dvbapi
echo "update setup.conf to use dvbapi"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/conf/dvbapi.conf -O /tmp/dvbapi.conf
cat /tmp/dvbapi.conf >> /etc/vdr/setup.conf

# return on previous folder
cd $PREVDIR




