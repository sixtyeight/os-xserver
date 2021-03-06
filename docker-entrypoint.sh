#!/bin/bash

if [ -z "$VNC_PASSWORD" ]; then
	echo >&2 'error: No password for VNC connection set.'
	echo >&2 '  Did you forget to add -e VNC_PASSWORD=... ?'
	exit 1
fi

if [ -z "$XFB_SCREEN" ]; then
	XFB_SCREEN=1024x768x24
fi

if [ ! -z "$XFB_SCREEN_DPI" ]; then
	DPI_OPTIONS="-dpi $XFB_SCREEN_DPI"
fi

# now boot X-Server, with security disabled and give it sometime to start up
Xvfb :0 $DPI_OPTIONS -ac -screen 0 $XFB_SCREEN >> /logs/xvfb.log 2>&1 &
sleep 2

# finally we can run the VNC-Server based on our just started X-Server
x11vnc -forever -shared -passwd $VNC_PASSWORD -display :0
