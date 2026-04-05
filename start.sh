#!/bin/bash

export DISPLAY=:0

# Start Xvfb
Xvfb :0 -screen 0 800x600x16 &
XVFB_PID=$!
echo "Xvfb PID: $XVFB_PID"
sleep 4

# Verify Xvfb is running
if ! kill -0 $XVFB_PID 2>/dev/null; then
  echo "ERROR: Xvfb failed to start"
  exit 1
fi

# Start openbox
DISPLAY=:0 openbox &
sleep 1

# Start x11vnc
DISPLAY=:0 x11vnc -display :0 -nopw -forever -shared -noxdamage -noncache -bg
sleep 3

# Verify x11vnc is on 5900
if ! nc -z localhost 5900; then
  echo "ERROR: x11vnc not listening on 5900"
  exit 1
fi

echo "All services up. Starting websockify on $PORT"
websockify --web=/usr/share/novnc/ $PORT localhost:5900
