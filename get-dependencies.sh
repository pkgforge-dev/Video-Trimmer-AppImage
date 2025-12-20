#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package and its dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
            video-trimmer \
            pipewire-jack \
            gst-libav \
            gst-plugins-bad \
            gst-plugins-ugly

if [ "$ARCH" = 'x86_64' ]; then
	echo "Installing 'libva-intel-driver' for older Intel's video HW acceleration"
	echo "---------------------------------------------------------------"
	pacman -Syu --noconfirm libva-intel-driver
fi

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
# gtk4-mini causes video preview in Video Trimmer to not work
get-debloated-pkgs --add-common --prefer-nano intel-media-driver ! gtk4
