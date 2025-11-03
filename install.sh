#!/bin/bash

yay -S ttf-firacode-nerd --noconfirm

# Installing Starship Prompt
#
curl -sS https://starship.rs/install.sh | sh

echo eval "$(starship init bash)" >> ~/.bashrc


cp alaritty.toml ~/.config/alacritty/

sudo pacman -S --needed - < packages.txt

yay -S --noconfirm - < aur-pkg.txt
