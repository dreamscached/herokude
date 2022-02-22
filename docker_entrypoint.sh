#!/bin/sh
export DISPLAY=:0
Xvfb -screen 0 "$GEOMETRY" & fluxbox &

eval $COMMANDLINE &

mkdir -p "$HOME/.vnc"
x11vnc -storepasswd "$PASSWORD" "$HOME/.vnc/passwd"

/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen "0.0.0.0:$PORT" &
x11vnc -rfbauth "$HOME/.vnc/passwd" -forever
