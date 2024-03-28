#!/bin/bash

# Determine the package manager
if command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
    REMOVE_CMD="sudo apt remove -y"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    REMOVE_CMD="sudo dnf remove -y"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    REMOVE_CMD="sudo pacman -Rs"
else
    echo "Unsupported package manager. Exiting."
    exit 1
fi

# 1. Uninstall terminator
$REMOVE_CMD terminator

# 2. Uninstall zsh
$REMOVE_CMD zsh

# 3. Remove oh-my-zsh and powerlevel10k theme
rm -rf $HOME/.oh-my-zsh
rm -f $HOME/.zshrc

# 4. Remove the custom Hack nerd font
FONT_DIR="$HOME/.local/share/fonts/HackNerdFont"
rm -f "$FONT_DIR/HackNerdFontMono-Regular.ttf"
fc-cache -fv

rm -rf "$HOME/.config/terminator"

echo "Uninstallation completed! You may need to restart your terminal."

