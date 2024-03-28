# Obedssetupscript

## Description

This README provides documentation for a setup script that installs zsh, ohmyzsh, a font, and terminator. The script automates the installation process for these tools, making it easier for developers to set up their development environment. The script is designed to work on Linux systems (apt and dnf).

## Tools
The script installs:
- zsh
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k theme](https://github.com/romkatv/powerlevel10k)
- [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)
- [Terminator](https://github.com/gnome-terminator/terminator) (Optional see [Options](#options))

## Installation

Clone the repository:

```bash
git clone https://github.com/Obedaya/obedssetupscript
```

Make the script executable:

```bash
cd obedssetupscript
chmod +x setup.sh
```

## Usage

```bash
./setup.sh
```

### Options
```bash
-t Install terminator
```

