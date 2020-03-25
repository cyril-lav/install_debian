#!/bin/bash

# Conditions : 
# - installer sudo
# - se situer dans le dossier install_debian-master 


# Vérification dossier
if [ ! $(basename $(pwd)) = "install_debian-master" ]; then
    echo "\033[1;31mVous devez être dans le dossier \"intall_debian-master\"\033[0m"
    exit 1
fi

# Vérification sudo
sudo echo 'oui' 1>/dev/null 2>/dev/null 

if [ "$?" != 0 ]
then
	echo "\033[1;31mVeuillez d'abord installer sudo\033[0m"
	exit 1
fi

# Sources apt
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
sudo cp fichiers/sources.list /etc/apt/

# Installation programmes (apt)
sudo apt update
sudo apt install -y xorg i3
sudo apt install -y pulseaudio pavucontrol alsa-utils
sudo apt install -y wicd-gtk
sudo apt install -y gdm3
sudo apt install -y feh
sudo apt install -y xfce4-screenshooter
sudo apt install -y zsh kitty
sudo apt install -y curl psmisc
sudo apt install -y libreoffice
sudo apt install -y dpkg
sudo apt install -y x11-xserver-utils 
sudo apt install -y fonts-noto-color-emoji
sudo apt install -y curl
sudo apt install -y xbindkeys
sudo apt install -y xbacklight
sudo apt install -y acpi
sudo apt install -y tlp
sudo apt install -y snap
sudo apt install -y vim
sudo apt install -y python-pip
sudo apt install -y rofi
sudo apt install -y gcc
sudo apt install -y alien
sudo apt install -y zip unzip
sudo apt install -y default-jdk
sudo apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
sudo apt install -y libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev



sudo chsh -s /bin/zsh $USER
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Installation programmes (dpkg ou autres )
	# Discord
    sudo wget -O Discord.deb https://discordapp.com/api/download?platform=linux&format=deb
    sudo dpkg -i Discord.deb
    sudo apt --fix-broken install
    sudo dpkg -i Discord.deb

    # VS-Code
    sudo wget -O VisualStudio-Code.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo dpkg -i VisualStudio-Code.deb
    sudo apt --fix-broken install
    sudo dpkg -i VisualStudio-Code.deb

    # Spotify
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install spotify-client

    # Polybar
    wget -O Polybar.tar https://github.com/polybar/polybar/releases/download/3.4.2/polybar-3.4.2.tar
    tar xvf Polybar.tar
    cd polybar
    ./build.sh
    cd ..

# Configurations
    # Grub config
    git clone https://github.com/vinceliuice/grub2-themes.git
    cd grub2-themes
    sudo ./install.sh -v
    cd ..

    # Kitty config
    mkdir -p /home/$USER/.config/kitty
    sudo cp fichiers/kitty.conf /home/$USER/.config/kitty/
	
    # zsh config
    sudo mv /home/$USER/.zshrc /home/$USER/.zshrc.old
    sudo cp fichiers/.zshrc /home/$USER/

    # profile config
    sudo mv /home/$USER/.profile /home/$USER/.profile.old
    sudo cp fichiers/.profile /home/$USER/

    # i3 config
    sudo mv /home/$USER/.config/i3/config /home/$USER/.config/i3/config.old
    sudo cp fichiers/i3/config /home/$USER/.config/i3/

    # i3wm-themer (par unix121)
    git clone https://github.com/unix121/i3wm-themer
    cd i3wm-themer/
    sudo pip install -r requirements.txt
    ./install_debian.sh
    cd ..

    # i3wm-themes (par Kthulu120)
    git clone https://github.com/Kthulu120/i3wm-themes
    cd i3wm-themes/scripts/
    ./apply_theme.sh Colors
    cd ../..

    # Polybar config
    sudo cp fichiers/polybar/config /home/$USER/.config/polybar
    sudo cp fichiers/polybar/launch.sh /home/$USER/.config/polybar
    sudo cp fichiers/polybar/spotify-script.py /home/$USER/.config/polybar

    # Feh config
    sudo cp -r fichiers/feh /home/$USER/.config

    # gdm3 config
    sudo dpkg-reconfigure gdm3

# Installation drivers
sudo apt install -y firmware-iwlwifi
sudo apt install -y firmware-misc-nonfree
sudo apt install -y xserver-xorg-video-intel
sudo apt install -y intel-microcode
sudo apt install -y linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//')

# Pour installer le driver nvidia + bumblebee, décommentez les lignes suivantes
#sudo apt purge -y nvidia-driver
#sudo apt purge -y xserver-xorg-video-nouveau
#sudo apt install -y nvidia-kernel-dkms nvidia-xconfig nvidia-settings nvidia-vdpau-driver vdpau-va-driver mesa-utils bumblebee-nvidia primus xserver-xorg-video-nvidia linux-headers-$(uname -r)
#sudo apt purge -y nvidia-persistenced



# Fin
echo
echo "\033[1;33mInstallation terminée. L'ordinateur va redémarrer ...\033[0m"
sleep 3
systemctl reboot
