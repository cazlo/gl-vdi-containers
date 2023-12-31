#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo -e "\n------------------ startup of Xfce4 window manager ------------------"

### disable screensaver and power management
xset -dpms &
xset s noblank &
xset s off &

if [[ ${TIGER_VNC_VIRTUALGL:-} == "true" ]]; then
  vglrun -wm /usr/bin/startxfce4 --replace > $HOME/wm.log &
else
  /usr/bin/startxfce4 --replace > $HOME/wm.log &
fi
sleep 1
cat $HOME/wm.log