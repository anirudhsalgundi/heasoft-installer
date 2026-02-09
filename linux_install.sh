#!/bin/bash

# Start a screen session to protect from disconnects
screen -S heasoft_install

# Automatically Detect Latest Version
LATEST_VER=$(curl -s https://heasarc.gsfc.nasa.gov/docs/software/lheasoft/download.html | \
             grep -oP 'heasoft-\K[0-9.]+(?=src\.tar\.gz)' | head -1)

if [ -z "$LATEST_VER" ]; then
    echo "Error: Could not detect version."
    exit 1
fi

echo "Installing HEASoft $LATEST_VER..."

# System Dependencies (Ubuntu/Debian)
sudo apt-get update
sudo apt-get -y install libreadline-dev libncurses5-dev ncurses-dev curl \
libcurl4 libcurl4-gnutls-dev xorg-dev make gcc g++ gfortran perl-modules \
libdevel-checklib-perl libfile-which-perl python3-dev python3-pip \
python3-setuptools python3-astropy python3-numpy python3-scipy python3-matplotlib

# Download and Extract
TARBALL="heasoft-${LATEST_VER}src.tar.gz"
URL="https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft${LATEST_VER}/${TARBALL}"

if [ ! -f "$TARBALL" ]; then
    curl -O $URL
fi

tar -zxf $TARBALL
cd "heasoft-${LATEST_VER}/BUILD_DIR/"

# Environment Cleanup (Essential for clean builds)
unset CFLAGS CXXFLAGS FFLAGS LDFLAGS
export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)
export PERL=$(which perl)
export PYTHON=/usr/bin/python3  # HEASARC recommends system python for source builds

# Configure, Build, and Install
# Using --prefix keeps things tidy. Default is within the source tree.
./configure > config.out 2>&1
make > build.log 2>&1
make install > install.log 2>&1

# Architecture Detection & Bashrc Setup
# This is the tricky part: HEASoft creates a dir like 'x86_64-pc-linux-gnu-libc2.35'
cd ../
HEADAS_DIR=$(pwd)
# Use a wildcard to find the actual platform directory created by 'make install'
PLATFORM_DIR=$(ls -d $HEADAS_DIR/x86_64*linux* 2>/dev/null | head -1)

if [ -n "$PLATFORM_DIR" ]; then
    echo "" >> ~/.bashrc
    echo "# HEASoft Configuration" >> ~/.bashrc
    echo "export HEADAS=$PLATFORM_DIR" >> ~/.bashrc
    echo "source \$HEADAS/headas-init.sh" >> ~/.bashrc
    echo "alias heainit='source \$HEADAS/headas-init.sh'" >> ~/.bashrc
    echo "HEASoft installation complete. Please restart your terminal or run 'source ~/.bashrc'"
else
    echo "Error: Platform directory not found. Check build.log for errors."
fi