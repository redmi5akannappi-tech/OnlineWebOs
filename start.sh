#!/bin/bash

export DISPLAY=:0

echo "Starting Xvfb..."
Xvfb :0 -screen 0 800x600x16 &
sleep 3  # give it time

echo "Starting openbox..."
openbox &
sleep 1

echo "Starting x11vnc..."
x11vnc -display :0 -nopw -forever -shared -noxdamage &
sleep 2  # IMPORTANT - wait before websockify starts

echo "Starting websockify on $PORT..."
websockify --web=/usr/share/novnc/ $PORT localhost:5900
