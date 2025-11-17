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
export DEPLOY_OPENGL=1
export DEPLOY_GSTREAMER=1
export DEPLOY_PIPEWIRE=1
export STARTUPWMCLASS=video-trimmer # For Wayland, this is 'org.gnome.gitlab.YaLTeR.VideoTrimmer', so this needs to be changed in desktop file manually by the user in that case until some potential automatic fix exists for this

# Deploy dependencies
quick-sharun /usr/bin/video-trimmer \
             /usr/bin/ffmpeg \
             /usr/bin/ffplay \
             /usr/bin/ffprobe

# Turn AppDir into AppImage
quick-sharun --make-appimage
