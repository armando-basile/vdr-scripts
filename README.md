# vdr-scripts
## description
Scripts and tools to setup VDR from scratch on linux os.
Goal of this project is keep up-to-date our VDR environment including plugins, skins and configuration files.

## usage
1. get [prepare_vdr.sh](https://github.com/armando-basile/vdr-scripts/wiki/prepare_vdr-shell-script) script, you could use 
> # wget https://github.com/armando-basile/vdr-scripts/raw/master/prepare_vdr.sh
> # chmod 775 prepare_vdr.sh
> # ./prepare_vdr.sh
2. get install_plugins.sh script, you could use 
> # wget https://github.com/armando-basile/vdr-scripts/raw/master/install_plugins.sh
> # chmod 775 install_plugins.sh
> # ./install_plugins.sh
3. edit scripts and config VDRVER, VDRBOX_FOLDER, VDRUSER vars
4. exec prepare_vdr.sh
5. run make into vdr generated folder
6. exec install_plugins.sh

## oscam users
To use oscam with dvbapi you need to install also oscam and update vdr-start and vdr-stop scripts


