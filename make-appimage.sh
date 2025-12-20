#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q video-trimmer | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/org.gnome.gitlab.YaLTeR.VideoTrimmer.svg
export DESKTOP=/usr/share/applications/org.gnome.gitlab.YaLTeR.VideoTrimmer.desktop
export DEPLOY_VULKAN=1
export DEPLOY_GSTREAMER=1
export DEPLOY_PIPEWIRE=1
export STARTUPWMCLASS=org.gnome.gitlab.YaLTeR.VideoTrimmer # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1

# Deploy dependencies
quick-sharun /usr/bin/video-trimmer \
             /usr/bin/ffmpeg \
             /usr/bin/ffplay \
             /usr/bin/ffprobe

# Turn AppDir into AppImage
quick-sharun --make-appimage
