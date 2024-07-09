#!/bin/bash

tput civis

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
  tput cnorm
  exit 1
}

# Ctrl+C
trap ctrl_c INT

# Variables de configuración
USER_HOME="/home/elgordoponcio"
ROOT_HOME="/root"

# Función para instalar paquetes
install_packages() {
  echo -e "${blueColour}[*] Actualizando e instalando paquetes...${endColour}"
  sudo apt update -y
  sudo apt install -y git curl kitty bat xclip httpx-toolkit subfinder moreutils lsd bspwm sxhkd zsh polybar picom wmname feh
  sudo apt install -y build-essential vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev 
  sudo apt install -y libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev
  sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev
# Por ahora saque el rofi ya que revienta todo 
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

  # .zshrc

  if [ -f "${USER_HOME}/.zshrc" ]; then
    rm -rf ${USER_HOME}/.zshrc
    cp zshrc ${USER_HOME}/.zshrc
  else
    cp zshrc ${USER_HOME}/.zshrc
  fi
  ## Root
  if [ -f "${ROOT_HOME}/.zshrc" ]; then
    rm -rf ${ROOT_HOME}/.zshrc
    sudo cp zshrc ${ROOT_HOME}/.zshrc
  else
    sudo cp zshrc ${ROOT_HOME}/.zshrc
  fi

  # .p10k.zsh

  if [ -f "${USER_HOME}/.p10k.zsh" ]; then
    rm -rf ${USER_HOME}/.p10k.zsh
    cp p10k.zsh ${USER_HOME}/.p10k.zsh
  else
    cp p10k.zsh ${USER_HOME}/.p10k.zsh
  fi
  ## Root
  if [ -f "${ROOT_HOME}/.p10k.zsh" ]; then
    rm -rf ${ROOT_HOME}/.p10k.zsh
    sudo cp p10k.zsh_root ${ROOT_HOME}/.p10k.zsh
  else
    sudo cp p10k.zsh_root ${ROOT_HOME}/.p10k.zsh
  fi

  # powerlevel10k

  if [ -d "${USER_HOME}/powerlevel10k" ]; then
    rm -rf ${USER_HOME}/powerlevel10k/*
    cp -r powerlevel10k/* ${USER_HOME}/powerlevel10k
  else
    mkdir ${USER_HOME}/powerlevel10k
    cp -r powerlevel10k/* ${USER_HOME}/powerlevel10k
  fi
  ## Root
  if [ -d "${ROOT_HOME}/powerlevel10k" ]; then
    rm -rf ${ROOT_HOME}/powerlevel10k/*
    sudo cp -r powerlevel10k_root/* ${ROOT_HOME}/powerlevel10k/
  else
    mkdir ${ROOT_HOME}/powerlevel10k
    sudo cp -r powerlevel10k_root/* ${ROOT_HOME}/powerlevel10k/
  fi

  # oh-my-zsh
    cp -r oh-my-zsh/* ${USER_HOME}/.oh-my-zsh/
  ## Root
    sudo cp -r oh-my-zsh_root/* ${ROOT_HOME}/.oh-my-zsh/
  
  # .config
  if [ -d "${USER_HOME}/.config" ]; then
    rm -rf ${USER_HOME}/.config/*
    cp -r config_Bspwm/config_user/* ${USER_HOME}/.config/
  else
    mkdir ${USER_HOME}/.config
    cp -r config_Bspwm/config_user/* ${USER_HOME}/.config/
  fi
  ## Root
  if [ -d "${ROOT_HOME}/.config" ]; then
    rm -rf ${ROOT_HOME}/.config/*
    sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config/
  else
    mkdir ${ROOT_HOME}/.config
    sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config/
  fi

  # Plugins 

  if [ -d "/usr/share/zsh-sudo " ]; then
    sudo cp sudo.plugin.zsh /usr/share/zsh-sudo/
  else
    sudo mkdir /usr/share/zsh-sudo
    sudo cp sudo.plugin.zsh /usr/share/zsh-sudo/
  fi

   if [ -d "/usr/share/zsh-autocomplete " ]; then
    sudo cp zsh-autocomplete.plugin.zsh /usr/share/zsh-autocomplete/
  else
    sudo mkdir /usr/share/zsh-autocomplete
    sudo cp zsh-autocomplete.plugin.zsh /usr/share/zsh-autocomplete/
  fi



  # Fonts
  if [ -d "/usr/local/share/fonts" ]; then
    rm -rf /usr/local/share/fonts/*
    cp -r fonts/* /usr/local/share/fonts/ 
  else
    sudo mkdir /usr/local/share/fonts 
    cp -r fonts/* /usr/local/share/fonts/ 
  fi

  if [ -d "/usr/share/fonts/truetype" ]; then
    sudo cp -r config_Bspwm/config_user/polybar/fonts/* /usr/share/fonts/truetype/
    sudo fc-cache -v
  else
    sudo mkdir /usr/share/fonts/truetype
    sudo cp -r config_Bspwm/config_user/polybar/fonts/* /usr/share/fonts/truetype/
    sudo fc-cache -fv
  fi


  # Wallpaper
  if [ -d "${USER_HOME}/Wallpapers" ]; then
    cp fondo.jpg ${USER_HOME}/Wallpapers/pexels-rpnickson-2478248.jpg
  else
    mkdir ${USER_HOME}/Wallpapers
    cp fondo.jpg ${USER_HOME}/Wallpapers/pexels-rpnickson-2478248.jpg
  fi

}

picom_install() {
  sudo apt install cmake 
  git clone https://github.com/yshui/picom.git && cd picom 
  meson setup --buildtype=release build
  ninja -C build
  ninja -C build install
}

rofi_install(){
  sudo cp rofi /usr/bin/rofi
  if [ ! -d "/usr/local/rofi" ];then
    mkdir /usr/local/rofi
    mkdir /usr/local/rofi/themes
    sudo cp -r rofi_themes/* /usr/local/rofi/themes/
  else
    sudo cp -r rofi_themes/* /usr/local/rofi/themes/
  fi
}

# Función para crear enlaces simbólicos
create_symlink() {
  sudo ln -s -f ${USER_HOME}.zshrc ${ROOT_HOME}/.zshrc
}

# Llamada a funciones
install_packages
install_oh_my_zsh
copy_config_files
picom_install 
rofi_install
create_symlink

echo -e "\n\n${greenColour}[*] Instalación terminada, sólo falta instalar BurpsuitePro y reiniciar...${endColour}\n"
tput cnorm
