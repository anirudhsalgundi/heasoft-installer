##
##

sudo apt-get -y install libreadline-dev libncurses5-dev ncurses-dev curl \
libcurl4 libcurl4-gnutls-dev xorg-dev make gcc g++ gfortran perl-modules \
libdevel-checklib-perl libfile-which-perl python3-dev python3-pip python3-setuptools \
python3-astropy python3-numpy python3-scipy python3-matplotlib

conda install astropy numpy scipy matplotlib pip

export PYTHON=$HOME/miniconda3/bin/python3

export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export FC=/usr/bin/gfortran
export PERL=/usr/bin/perl
export PYTHON=/usr/bin/python3

unset CFLAGS CXXFLAGS FFLAGS LDFLAGS build_alias host_alias
export PATH="/usr/bin:$PATH"

cd heasoft-6.35.1/BUILD_DIR/
./configure
make
make install

echo "export HEADAS=/path/to/your/installed/heasoft-6.35.1/*x*86*" >> ~/.bashrc
echo "source $HEADAS/headas-init.sh" >> ~/.bashrc




