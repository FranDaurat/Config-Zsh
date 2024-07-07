#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT


# Asegúra tener las dependencias instaladas
sudo apt update -y
sudo apt install -y git curl kitty bat xclip httpx-toolkit subfinder moreutils lsd bspwm sxhkd

# Instala oh-my-zsh y plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/elgordoponcio/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions /home/elgordoponcio/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/elgordoponcio/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Copia y borrado de archivos de configuración

## zsh
cp zshrc /home/elgordoponcio/.zshrc
sudo cp zshrc /root/.zshrc
cp -r oh-my-zsh /home/elgordoponcio/.oh-my-zsh
sudo cp -r oh-my-zsh_root /root/.oh-my-zsh
sudo ln -s -f /home/elgordoponcio/.zshrc /root/.zshrc
## p10k
cp p10k.zsh /home/elgordoponcio/.p10k.zsh
sudo cp p10k.zsh_root /root/.p10k.zsh
cp -r powerlevel10k /home/elgordoponcio/powerlevel10k
sudo cp -r powerlevel10k_root /root/powerlevel10k

## .config
cp -r config_Bspwm/config_user/ /home/elgordoponcio/.config
sudo cp -r config_Bspwm/config_root/ /root/.config

## kitty
#cp color.ini /home/elgordoponcio/.config/kitty/color.ini
#cp kitty.conf /home/elgordoponcio/.config/kitty/kitty.conf
#sudo cp color.ini /root/.config/kitty/color.ini
#sudo cp kitty.conf /root/.config/kitty/kitty.conf

# Fuente de los archivos de configuración
source /home/elgordoponcio/.zshrc
source /home/elgordoponcio/.p10k.zsh
sudo source /root/.zshrc
sudo source /root/.p10k.zsh

echo "\n\n${greenColour}[*] Instalación terminada, solo falta instalar el BurpsuitPro y reiniciar...${endColour}\n"

