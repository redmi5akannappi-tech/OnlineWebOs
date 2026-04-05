#!/bin/bash

export DISPLAY=:0

echo "Starting virtual display..."
Xvfb :0 -screen 0 1024x768x16 &

sleep 2

echo "Starting window manager..."
openbox &

echo "Starting XFCE panel..."
xfce4-panel &

echo "Starting VNC server..."
x11vnc -display :0 -nopw -forever -shared &

echo "Starting noVNC on port $PORT..."
websockify --web=/usr/share/novnc/ $PORT localhost:5900
