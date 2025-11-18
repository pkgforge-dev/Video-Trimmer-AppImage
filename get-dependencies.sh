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

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Installing regular gtk4 instead of the debloated one..."
echo "---------------------------------------------------------------"
pacman -Rns --noconfirm gtk4
pacman -Syu --noconfirm gtk4
