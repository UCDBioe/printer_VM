# NOTES-
# Add Ubuntu host machine user to vboxusers group
# sudo adduser $USER vboxusers
#
# Add gnome-system-tools to allow for usb pass-through in virtualbox
# sudo apt-get install gnome-system-tools
# start application "Users and Groups" from Dash
# make sure Advanced settings - User Privileges - Virtualbox virtualization solution is checked


apt-get update

apt-get install -y git 

apt-get install -y vim

# Configure vim
echo "--------- Install Pathogen --------"
# Install Pathogen
mkdir /home/vagrant/.vim/
mkdir /home/vagrant/.vim/autoload/ 
mkdir /home/vagrant/.vim/bundle/ 
# Fix CURL certifications path:
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
curl -LSso /home/vagrant/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "--------- Install Nerdtree --------"
# Install Nerdtree
cd /home/vagrant/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git

echo "--------- Install Vundle --------"
# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git /home/vagrant/.vim/bundle/Vundle.vim

# Install pronterface
apt-get install -y python-serial python-wxgtk2.8 python-pyglet python-numpy cython python-libxml2 python-gobject python-dbus python-psutil python-cairosvg

python2 setup.py build_ext --inplace
# Already installed for pronterface
#   - git

# For installing CairoSVG in pip later
apt-get install -y libffi-dev 


# Install arduino
#tar xfJ arduino-1.6.8-linux64.tar.xz
#./arduino-1.6.8/install.sh
apt-get install -y arduino arduino-core

# Add user to dialout group so arduino works
usermod -a -G dialout vagrant
# chmod a+rw /dev/ttyACM0


# Install anaconda
condafile=Anaconda3-2.5.0-Linux-x86_64.sh

cd /home/vagrant/Downloads
wget -q --show-progress http://repo.continuum.io/archive/$condafile 
chmod +x $condafile
./$condafile -b -p /home/vagrant/anaconda

# add for conda install
echo -e "\n# Add path for anaconda: SL\n" >> /home/vagrant/.bashrc 
echo -e "export PATH=\"/home/vagrant/anaconda/bin:$PATH\"" >> /home/vagrant/.bashrc 

# Needed for vagrant provision to see the installed anaconda directory
PATH=$PATH:/home/vagrant/anaconda/bin 

conda --version
conda create -y --name bioprint python=2.7 pyserial wxpython pycairo numpy

source activate bioprint 

pip install --upgrade pip

pip install CairoSVG
conda install -y -c http://conda.anaconda.org/erik pyglet1.2

source deactivate 

# May need to do this after uagrant up
#chown -R vagrant:vagrant anaconda
# chmod a+rw /dev/ttyACM0

echo "!-!-! Run :PluginInstall from vim when VM is running !-!-!"


