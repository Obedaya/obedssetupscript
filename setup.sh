#!/bin/bash

INSTALL_TERMINATOR=false

# Process arguments
while getopts "t" opt; do
  case $opt in
    t) INSTALL_TERMINATOR=true ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

# Determine the package manager
if command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
    UPDATE_CMD="sudo apt update"
    INSTALL_CMD="sudo apt install -y"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    UPDATE_CMD="sudo dnf check-update"
    INSTALL_CMD="sudo dnf install -y"
else
    echo "Unsupported package manager. Exiting."
    exit 1
fi

# Update packages
$UPDATE_CMD

FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf"
FONT_DIR="$HOME/.local/share/fonts/HackNerdFont"
mkdir -p "$FONT_DIR"
wget -O "$FONT_DIR/HackNerdFontMono-Regular.ttf" "$FONT_URL"
fc-cache -fv

if $INSTALL_TERMINATOR; then
	# 1. Install terminator
	$INSTALL_CMD terminator
	# Terminator Configuration
	TERMINATOR_CONFIG_PATH="$HOME/.config/terminator/config"

	# Ensure the directory exists
	mkdir -p "$(dirname "$TERMINATOR_CONFIG_PATH")"

	# Backup the current config (if it exists)
	if [[ -f "$TERMINATOR_CONFIG_PATH" ]]; then
    		cp "$TERMINATOR_CONFIG_PATH" "${TERMINATOR_CONFIG_PATH}.backup"
	fi

	# Copy the new configuration
	cp "terminator_config" "$TERMINATOR_CONFIG_PATH"

	echo "Terminator config updated. Please restart Terminator for changes to take effect."
fi

# 2. Install zsh
$INSTALL_CMD zsh

# Set zsh as the default shell
chsh -s $(which zsh)

# 3. Install oh-my-zsh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 4. Clone powerlevel10k theme and set it in .zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

cp zshrc_config ~/.zshrc
