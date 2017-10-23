#!/bin/bash
# File Name: antixccgrub.sh
# Purpose: allow user to set boot grub background
# Authors: anticapitalista
# Latest Change: 05 April 2017
##########################################################################



# Check that xserver is running and user is root.
[[ $DISPLAY ]] || { echo "There is no xserver running. Exiting..." ; exit 1 ; }
[[ $(id -u) -eq 0 ]] || { yad --image "error" --text "You need to be root\! \n\nCannot continue." ; exit 1 ; }


export GRUBBACKGROUND='
<window title="Grub Background" icon="gnome-control-center" window-position="1">

<vbox>
  <chooser>
    <height>500</height><width>600</width>
    <variable>BACKGROUND</variable>
  </chooser>

  <hbox>
    <button>
     <label>"View"</label>
	<input file>"/usr/share/icons/Faenza-Cupertino-mini/actions/32/gtk-find.png"</input>
        <action>feh -g 320x240 "$BACKGROUND" </action>
    </button>

    <button>
    <label>"Commit"</label>
	<input file>"/usr/share/icons/Faenza-Cupertino-mini/actions/32/dialog-yes.png"</input>
        <action>cp -bv "$BACKGROUND" /usr/share/wallpaper/back.jpg </action>
	<action>update-grub</action>
        <action>yad --text "Done!"</action> 
	<action>EXIT:close</action>
    </button>
    
    <button>
    <label>"Cancel"</label>
	<input file>"/usr/share/icons/Faenza-Cupertino-mini/actions/32/dialog-no.png"</input>
	<action>EXIT:close</action>
    </button>
  </hbox>
</vbox>

</window>
'

gtkdialog --program=GRUBBACKGROUND
