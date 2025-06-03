#!/bin/zsh#!/bin/zsh

echo "We, will proceed to install heasoft in creating a screen instance "heasoft_install" which will not break the installation process if your machine gets logged out"
screen -S heasoft_install

cd ../
heasoft_dir=$(pwd)
cd $heasoft_dir/BUILD_DIR

#Install necessary packages
brew install libpng
brew install gcc@14

echo "Assuming you have conda installed, let us create a new environment called hea, that will isolate all the installation versions for python and other libraries specific to heasoft"

#create conda environment to avoid system clashes with library versions
#conda create --name hea -y

#activate the environment
#conda activate hea


echo "Installing libraries"
conda install astropy numpy scipy matplotlib pip
pip install stingray

export CC=$(which cc)
export CXX=$(which c++)
export PERL=$(which perl)
export FC=$(which gfortran)

export PYTHON=$CONDA_PREFIX/envs/hea/bin/python
unset CFLAGS CXXFLAGS FFLAGS LDFLAGS build_alias host_alias
export PATH="/usr/bin:$PATH"



/configure --with-png=/opt/homebrew
make
make install

architecture_dir=$(echo "$heasoft_dir"/*apple*darwin*)
echo "export HEADAS=\"$architecture_dir\"" > ~/.zshrc
echo "source \$HEADAS/headas-init.sh" >> ~/.zshrc
screen -X -S heasoft_install quit

echo "Heasoft installation complete." #You can now use the heasoft tools in your conda environment."
#echo "To activate the environment, use: 'conda activate hea' and then use the heasoft tools"
