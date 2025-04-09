#!/bin/sh

sudo apt install build-essential gettext dos2unix python3-pyqt5 \
	libxcb-glx0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
	libxcb-randr0 libxcb-render0 libxcb-render-util0 \
	libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb-util1 \
	libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 \

python3 -m pip install pyinstaller

fsbuild/version

fsbuild/bootstrap

fsbuild/configure

fsbuild/build

fsbuild/bundle

fsbuild/archive