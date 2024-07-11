#!/bin/bash

grub_install(){
  sudo cp -r background.png /boot/grub/themes/kali
  sudo cp -r _background.png /boot/grub/
  sudo cp -r grub-4x3.png /boot/grub/themes/kali
  sudo cp -r grub-16x9.png /boot/grub/themes/kali
  sudo update-grub
}

grub_install
