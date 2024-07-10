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
  export DEBIAN_FRONTEND=noninteractive
  sudo apt update -y &>/dev/null
  sudo apt install -y git curl kitty bat xclip httpx-toolkit subfinder moreutils lsd bspwm sxhkd zsh polybar picom wmname &>/dev/null
  sudo apt install -y build-essential vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev &>/dev/null
  sudo apt install -y libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev &>/dev/null
  sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev &>/dev/null
  # Por ahora saque el rofi y el feh  ya que revienta todo
}

# Función para instalar oh-my-zsh y plugins
install_oh_my_zsh() {
  echo -e "${blueColour}[*] Instalando oh-my-zsh y plugins...${endColour}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null &
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null &
  wait

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${USER_HOME}/.oh-my-zsh/custom/themes/powerlevel10k &>/dev/null
  git clone https://github.com/zsh-users/zsh-autosuggestions ${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions &>/dev/null
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &>/dev/null

  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ROOT_HOME}/.oh-my-zsh/custom/themes/powerlevel10k &>/dev/null
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ROOT_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions &>/dev/null
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ROOT_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &>/dev/null
}

# Función para copiar archivos de configuración
copy_config_files() {
  echo -e "${blueColour}[*] Copiando archivos de configuración...${endColour}"
  # .config
  if [ -d "${USER_HOME}/.config" ]; then
    rm -rf ${USER_HOME}/.config/* &>/dev/null
    cp -r config_Bspwm/config_user/* ${USER_HOME}/.config/ &>/dev/null
  else
    mkdir ${USER_HOME}/.config &>/dev/null
    cp -r config_Bspwm/config_user/* ${USER_HOME}/.config/ &>/dev/null
  fi
  ## Root
  if [ -d "${ROOT_HOME}/.config" ]; then
    rm -rf ${ROOT_HOME}/.config/* &>/dev/null
    sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config/ &>/dev/null
  else
    mkdir ${ROOT_HOME}/.config &>/dev/null
    sudo cp -r config_Bspwm/config_root/* ${ROOT_HOME}/.config/ &>/dev/null
  fi

  # nvim
  cp -r nvim /opt &>/dev/null
  # feh
  sudo cp feh /usr/bin &>/dev/null

  # Wallpaper
  if [ -d "${USER_HOME}/Wallpapers" ]; then
    cp fondo.jpg ${USER_HOME}/Wallpapers/pexels-rpnickson-2478248.jpg &>/dev/null
  else
    mkdir ${USER_HOME}/Wallpapers &>/dev/null
    cp fondo.jpg ${USER_HOME}/Wallpapers/pexels-rpnickson-2478248.jpg &>/dev/null
  fi

}

ohmyzsh-powerlevel10k_install() {
  echo -e "${blueColour}[*] Copiando archivos de oh-my-zsh y powerlevel10k...${endColour}"

  if [ -d "${USER_HOME}/powerlevel10k" ]; then
    rm -rf ${USER_HOME}/powerlevel10k/* &>/dev/null
    cp -r powerlevel10k/* ${USER_HOME}/powerlevel10k &>/dev/null
  else
    mkdir ${USER_HOME}/powerlevel10k &>/dev/null
    cp -r powerlevel10k/* ${USER_HOME}/powerlevel10k &>/dev/null
  fi
  ## Root
  if [ -d "${ROOT_HOME}/powerlevel10k" ]; then
    rm -rf ${ROOT_HOME}/powerlevel10k/* &>/dev/null
    sudo cp -r powerlevel10k_root/* ${ROOT_HOME}/powerlevel10k/ &>/dev/null
  else
    mkdir ${ROOT_HOME}/powerlevel10k &>/dev/null
    sudo cp -r powerlevel10k_root/* ${ROOT_HOME}/powerlevel10k/ &>/dev/null
  fi

  cp -r oh-my-zsh/* ${USER_HOME}/.oh-my-zsh/ &>/dev/null
  ## Root
  sudo cp -r oh-my-zsh_root/* ${ROOT_HOME}/.oh-my-zsh/ &>/dev/null

}

plugins_install() {
  echo -e "${blueColour}[*] Instalando plugins...${endColour}"
  if [ -d "/usr/share/zsh-sudo " ]; then
    sudo cp sudo.plugin.zsh /usr/share/zsh-sudo/ &>/dev/null
  else
    sudo mkdir /usr/share/zsh-sudo &>/dev/null
    sudo cp sudo.plugin.zsh /usr/share/zsh-sudo/ &>/dev/null
  fi

  if [ -d "/usr/share/zsh-autocomplete " ]; then
    sudo cp zsh-autocomplete.plugin.zsh /usr/share/zsh-autocomplete/ &>/dev/null
  else
    sudo mkdir /usr/share/zsh-autocomplete &>/dev/null
    sudo cp zsh-autocomplete.plugin.zsh /usr/share/zsh-autocomplete/ &>/dev/null
  fi
}

zsh-p10k_install() {
  echo -e "${blueColour}[*] Configurando zshrc y p10k...${endColour}"
  # .zshrc
  if [ -f "${USER_HOME}/.zshrc" ]; then
    rm -rf ${USER_HOME}/.zshrc &>/dev/null
    cp zshrc ${USER_HOME}/.zshrc &>/dev/null
  else
    cp zshrc ${USER_HOME}/.zshrc &>/dev/null
  fi
  ## Root
  if [ -f "${ROOT_HOME}/.zshrc" ]; then
    rm -rf ${ROOT_HOME}/.zshrc &>/dev/null
    sudo cp zshrc ${ROOT_HOME}/.zshrc &>/dev/null
  else
    sudo cp zshrc ${ROOT_HOME}/.zshrc &>/dev/null
  fi

  wait
  if [ -f "${ROOT_HOME}/.zshrc" ]; then
    ln -s -f ${USER_HOME}/.zshrc ${ROOT_HOME}/.zshrc &>/dev/null
  fi
  # .p10k.zsh
  if [ -f "${USER_HOME}/.p10k.zsh" ]; then
    rm -rf ${USER_HOME}/.p10k.zsh &>/dev/null
    cp p10k.zsh ${USER_HOME}/.p10k.zsh &>/dev/null
  else
    cp p10k.zsh ${USER_HOME}/.p10k.zsh &>/dev/null
  fi
  ## Root
  if [ -f "${ROOT_HOME}/.p10k.zsh" ]; then
    rm -rf ${ROOT_HOME}/.p10k.zsh &>/dev/null
    sudo cp p10k.zsh_root ${ROOT_HOME}/.p10k.zsh &>/dev/null
  else
    sudo cp p10k.zsh_root ${ROOT_HOME}/.p10k.zsh &>/dev/null
  fi

}

fonts_install() {
  echo -e "${blueColour}[*] Instalando fuentes...${endColour}"

  if [ -d "/usr/local/share/fonts" ]; then
    rm -rf /usr/local/share/fonts/* &>/dev/null
    cp -r fonts/* /usr/local/share/fonts/ &>/dev/null
  else
    sudo mkdir /usr/local/share/fonts &>/dev/null
    cp -r fonts/* /usr/local/share/fonts/ &>/dev/null
  fi

  if [ -d "/usr/share/fonts/truetype" ]; then
    sudo cp -r config_Bspwm/config_user/polybar/fonts/* /usr/share/fonts/truetype/ &>/dev/null
    sudo fc-cache -v &>/dev/null
  else
    sudo mkdir /usr/share/fonts/truetype &>/dev/null
    sudo cp -r config_Bspwm/config_user/polybar/fonts/* /usr/share/fonts/truetype/ &>/dev/null
    sudo fc-cache -v &>/dev/null
  fi
}

fzf_install() {
  echo -e "${blueColour}[*] Instalando fzf...${endColour}"

  git clone --depth 1 https://github.com/junegunn/fzf.git ${USER_HOME}/.fzf  &>/dev/null
  ${USER_HOME}/.fzf/install --all &>/dev/null 
  cp fzf.zsh ${USER_HOME}/.fzf.zsh &>/dev/null

  sudo git clone --depth 1 https://github.com/junegunn/fzf.git ${ROOT_HOME}/.fzf &>/dev/null
  sudo ${ROOT_HOME}/.fzf/install --all &>/dev/null
  sudo cp fzf.zsh ${ROOT_HOME}/.fzf.zsh &>/dev/null
}


picom_install() {
  echo -e "${blueColour}[*] Instalando picom...${endColour}"
  sudo apt install -y cmake &>/dev/null

  (
    git clone https://github.com/yshui/picom.git &>/dev/null
    cd picom
    meson setup --buildtype=release build &>/dev/null
    ninja -C build &>/dev/null
    sudo ninja -C build install &>/dev/null
    cd ..
    rm -rf picom &>/dev/null
  ) &>/dev/null
}


rofi_install(){

if [ -f "./rofi_install" ]; then
  chmod +x ./rofi_install
  ./rofi_install
else
  echo -e "${redColour}[!] El archivo rofi_install no se encontró. Omita esta parte de la instalación.${endColour}"
fi

}

# Llamada a funciones
install_packages
install_oh_my_zsh
copy_config_files
ohmyzsh-powerlevel10k_install
plugins_install
zsh-p10k_install
fonts_install
fzf_install
picom_install
rofi_install
wait

echo -e "\n\n${greenColour}[+] ¡Instalación terminada!${endColour}\n"
tput cnorm
