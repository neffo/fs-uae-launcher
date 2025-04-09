#!/bin/sh

set -e

# create symlinks for some libraries

ln -s -r $1/libpython3.11.so $1/libpython3.11.so.1
ln -s -r $1/libpython3.11.so $1/libpython3.11.so.1.0
