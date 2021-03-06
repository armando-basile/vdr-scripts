#!/bin/bash
set -e

# Script for VDR environment preparation
# rel. 0.1.0

# release to checkout
VDRVER=2.2.0
VDRBOX_FOLDER="vdrbox"
VDRUSER="mediacenter"
PREVDIR=`pwd`

# detect if is superuser
if [[ $EUID -ne 0 ]]; then
   echo -e "This script must be run as root\n"
   exit 1
fi

# check for parameter presence
if [ ! -z $1 ]; then
    VDRVER=$1
fi

# create vdrbox folder
echo "checking for /$VDRBOX_FOLDER folder presence"
if [ ! -d "/$VDRBOX_FOLDER" ]; then
    echo -e "creating /$VDRBOX_FOLDER folder"
    mkdir "/$VDRBOX_FOLDER"
fi

# move into folder
cd "/$VDRBOX_FOLDER"


# get vdr into specific folder
echo "checking for /$VDRBOX_FOLDER/vdr-$VDRVER folder presence" 
if [ ! -d "/$VDRBOX_FOLDER/vdr-$VDRVER" ]; then
    echo -e "get snapshot vdr-$VDRVER from git\n"
    wget "http://projects.vdr-developer.org/git/vdr.git/snapshot/vdr-vdr-$VDRVER.tar.gz"
    tar xf "vdr-vdr-$VDRVER.tar.gz"
    rm -f "vdr-vdr-$VDRVER.tar.gz"
    mv "vdr-vdr-$VDRVER" "vdr-$VDRVER"
fi

# move into plugins folder
cd "vdr-$VDRVER/PLUGINS"

# create lib folder for plugins binaries
if [ ! -d "lib" ]; then
    echo -e "creating lib folder for plugins binaries"
    mkdir lib
fi

# move into plugins source folder
cd src

# remove unused plugins
rm -rf dvbhddevice dvbsddevice hello pictures rcu skincurses

# get plugins from git
if [ ! -d "softhddevice" ]; then
    echo -e "\nget softhddevice plugin from git"
    git clone git://projects.vdr-developer.org/vdr-plugin-softhddevice.git softhddevice
fi

if [ ! -d "skinnopacity" ]; then
    echo -e  "\nget skin-nopacity plugin from git"
    git clone git://projects.vdr-developer.org/skin-nopacity.git skinnopacity
    # set to use graphicsmagick instead imagemagick
    sed -i 's/IMAGELIB = imagemagick/IMAGELIB = graphicsmagick/g' skinnopacity/Makefile
fi

if [ ! -d "tvguide" ]; then
    echo -e  "\nget tvguide plugin from git"
    git clone git://projects.vdr-developer.org/vdr-plugin-tvguide.git tvguide
    # set to use graphicsmagick instead imagemagick
    sed -i 's/IMAGELIB = imagemagick/IMAGELIB = graphicsmagick/g' tvguide/Makefile
fi

if [ ! -d "dvbapi" ]; then
    echo -e  "\nget dvbapi plugin from git"
    git clone https://github.com/manio/vdr-plugin-dvbapi.git dvbapi
fi

if [ ! -d "loadepg" ]; then
    echo -e  "\nget loadepg plugin from lukkinosat website"
    wget http://lukkinosat.altervista.org/vdr-loadepg-0.2.5.tgz
    tar xf vdr-loadepg-0.2.5.tgz
    mv loadepg-0.2.5 loadepg
fi

if [ ! -d "femon" ]; then
    echo -e  "\nget femon plugin from rahrenbe website"
    wget http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/vdr-femon-2.2.0.tgz
    tar xf vdr-femon-2.2.0.tgz
    mv femon-2.2.0 femon
fi

# return on main folder
cd "/$VDRBOX_FOLDER"

# get vdr and oscam start/stop scripts
echo -e  "\nget start/stop vdr and oscam scripts:"
echo -e  "oscam-start.sh"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/oscam-start.sh -O oscam-start.sh
echo -e  "oscam-stop.sh"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/oscam-stop.sh -O oscam-stop.sh
echo -e  "vdr-start.sh"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/vdr-start.sh -O vdr-start.sh
echo -e  "vdr-stop.sh"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/vdr-stop.sh -O vdr-stop.sh
echo -e  "vdr-run.sh"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/vdr-run.sh -O vdr-run.sh
chmod 775 oscam-start.sh
chmod 775 oscam-stop.sh
chmod 775 vdr-start.sh
chmod 775 vdr-stop.sh
chmod 775 vdr-run.sh


# create vdr config files folders
echo -e  "\ncreating vdr config filesystem"
mkdir -p /etc/vdr/themes
mkdir -p /etc/vdr/plugins/skinnopacity/themeconfigs
mkdir -p /etc/vdr/plugins/loadepg
mkdir -p /usr/local/share/vdr/plugins/skinnopacity
mkdir -p /usr/local/share/vdr/plugins/tvguide

# get default config files for vdr
echo -e  "\nget remote.conf file for remote key mapping"
wget -q https://github.com/armando-basile/vdr-scripts/raw/master/conf/remote.conf -O /etc/vdr/remote.conf

# get channels logo folder
if [ ! -d "/usr/local/share/vdr/plugins/skinnopacity/logos" ]; then
    # clone repo
    echo -e  "\nget channels logos from 3PO/Senderlogos git"
    git clone https://github.com/3PO/Senderlogos /usr/local/share/vdr/plugins/skinnopacity/logos
else
    # update local copy
    echo -e  "\nupdate channels logos from 3PO/Senderlogos git"
    cd /usr/local/share/vdr/plugins/skinnopacity/logos
    git pull
fi

# set owner for vdr main folder
chown -R "$VDRUSER:$VDRUSER" "/$VDRBOX_FOLDER"

echo -e  "\n\nReady to build, go to /$VDRBOX_FOLDER/vdr-$VDRVER folder and launch make"

# return on previous folder
cd $PREVDIR


