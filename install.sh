#!/bin/bash

# Installing Starship Prompt
#
curl -sS https://starship.rs/install.sh | sh

echo eval "$(starship init bash)" >> ~/.bashrc


cp alaritty.toml ~/.config/alacritty/

sudo pacman -S --needed - < packages.txt

yay -S --noconfirm - < aur-pkg.txt

cp .fonts/NotoColorEmoji-Regular.ttf ~/.local/share/fonts/
