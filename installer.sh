#!/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c() {
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT

# Variables de configuración
USER_HOME="/home/elgordoponcio"
ROOT_HOME="/root"

# Función para instalar paquetes
install_packages() {
  echo -e "${blueColour}[*] Actualizando e instalando paquetes...${endColour}"
  sudo apt update -y && sudo apt upgrade -y
  sudo apt install -y git curl kitty bat xclip httpx subfinder moreutils lsd bspwm sxhkd zsh \
      build-essential vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev \
      libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev polybar picom rofi
}

# Función para instalar oh-my-zsh y plugins
install_oh_my_zsh() {
  echo -e "${blueColour}[*] Instalando oh-my-zsh y plugins...${endColour}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-autosuggestions ${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ROOT_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ROOT_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

# Función para copiar archivos de configuración
copy_config_files() {
  echo -e "${blueColour}[*] Copiando archivos de configuración...${endColour}"
  
  # Zsh
  cp zshrc ${USER_HOME}/.zshrc
  sudo cp zshrc ${ROOT_HOME}/.zshrc
  
  # Powerlevel10k
  cp p10k.zsh ${USER_HOME}/.p10k.zsh
  sudo cp p10k.zsh_root ${ROOT_HOME}/.p10k.zsh
  cp -r powerlevel10k ${USER_HOME}/powerlevel10k
  sudo cp -r powerlevel10k_root ${ROOT_HOME}/powerlevel10k	
  
  # .config
  cp -r config_Bspwm/config_user/* ${USER_HOME}/.config
  sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config
  cp -r fonts /usr/local/share/fonts 
  cp fondo.jpg ${USER_HOME}/Wallpapers/pexels-rpnickson-2478248.jpg
}

# Función para crear enlaces simbólicos
#create_symlinks() {
#  echo -e "${blueColour}[*] Creando enlaces simbólicos...${endColour}"
#  ln -s ${USER_HOME}/.oh-my-zsh ${USER_HOME}/.oh-my-zsh/oh-my-zsh.sh
#  sudo ln -s ${ROOT_HOME}/.oh-my-zsh ${ROOT_HOME}/.oh-my-zsh/oh-my-zsh.sh#

#  ln -s ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh
#  sudo ln -s ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh
#}

# Llamada a funciones
install_packages
install_oh_my_zsh
copy_config_files
#create_symlinks

echo -e "\n\n${greenColour}[*] Instalación terminada, sólo falta instalar BurpsuitPro y reiniciar...${endColour}\n"
