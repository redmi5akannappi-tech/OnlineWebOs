#!/bin/bash

export DISPLAY=:0

Xvfb :0 -screen 0 800x600x16 &
sleep 4

DISPLAY=:0 openbox &
sleep 1

# Paint background so it's not black
DISPLAY=:0 xsetroot -solid grey &

# Auto open a terminal so you have something to use
DISPLAY=:0 x11vnc -display :0 -nopw -forever -shared -noxdamage -noncache -bg
sleep 3

websockify --web=/usr/share/novnc/ $PORT localhost:5900
