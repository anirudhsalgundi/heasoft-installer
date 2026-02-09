#!/bin/zsh

# Protect the session
screen -S heasoft_install

# Detect Latest Version
LATEST_VER=$(curl -s https://heasarc.gsfc.nasa.gov/docs/software/lheasoft/download.html | \
             grep -oP 'heasoft-\K[0-9.]+(?=src\.tar\.gz)' | head -1)

if [[ -z "$LATEST_VER" ]]; then
    echo "Error: Could not detect version."
    exit 1
fi

#Install necessary packages
echo "Installing dependencies via Homebrew..."
brew install libpng gcc make curl libxml2 xquartz

echo "Assuming you have conda installed, let us create a new environment called hea, that will isolate all the installation versions for python and other libraries specific to heasoft"

#create conda environment to avoid system clashes with library versions
#conda create --name hea -y

#activate the environment
#conda activate hea

TARBALL="heasoft-${LATEST_VER}src.tar.gz"
URL="https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft${LATEST_VER}/${TARBALL}"

if [[ ! -f "$TARBALL" ]]; then
    echo "Downloading $TARBALL..."
    curl -O $URL
fi

tar -zxf $TARBALL
cd "heasoft-${LATEST_VER}/BUILD_DIR/"


echo "Installing libraries"
pip install astropy numpy scipy matplotlib stingray

export CC=$(which cc)
export CXX=$(which c++)
export PERL=$(which perl)
export FC=$(which gfortran)

export PYTHON=$CONDA_PREFIX/envs/hea/bin/python
unset CFLAGS CXXFLAGS FFLAGS LDFLAGS build_alias host_alias
export PATH="/usr/bin:$PATH"



./configure --with-png=/opt/homebrew
make
make install > install.log 2>&1

# architecture_dir=$(echo "$heasoft_dir"/*apple*darwin*)
# echo "export HEADAS=\"$architecture_dir\"" > ~/.zshrc
# echo "source \$HEADAS/headas-init.sh" >> ~/.zshrc
# screen -X -S heasoft_install quit

# 8. Path Configuration for .zshrc
cd ../
HEADAS_DIR=$(pwd)
# Detect the specific apple-darwin directory
PLATFORM_DIR=$(ls -d $HEADAS_DIR/*apple-darwin* 2>/dev/null | head -1)

if [[ -n "$PLATFORM_DIR" ]]; then
    echo "" >> ~/.zshrc
    echo "# HEASoft Configuration" >> ~/.zshrc
    echo "export HEADAS=$PLATFORM_DIR" >> ~/.zshrc
    echo "source \$HEADAS/headas-init.sh" >> ~/.zshrc
    echo "alias heainit='source \$HEADAS/headas-init.sh'" >> ~/.zshrc
    
    
    echo "HEASoft installation complete."
else
    echo "Error: Platform directory not found. Check build.log for errors."
fi

echo "Heasoft installation complete." #You can now use the heasoft tools in your conda environment."
#echo "To activate the environment, use: 'conda activate hea' and then use the heasoft tools"
