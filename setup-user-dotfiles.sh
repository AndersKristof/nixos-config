#!/usr/bin/env bash

# Script to set up user dotfiles without home-manager

USER_HOME="/home/${USER}"
mkdir -p "${USER_HOME}/.config/alacritty"
mkdir -p "${USER_HOME}/.config/git"

# Create Alacritty configuration
cat > "${USER_HOME}/.config/alacritty/alacritty.toml" << 'EOF'
[window]
padding = { x = 5, y = 5 }

[font]
size = 12

[font.normal]
family = "Source Code Pro"
style = "Regular"

[colors.primary]
background = "#1e1e1e"
foreground = "#d4d4d4"
EOF

# Create Git configuration
cat > "${USER_HOME}/.config/git/config" << EOF
[user]
    name = Anders Kristoffersen
    email = anders.kristof@gmail.com

[init]
    defaultBranch = main

[pull]
    rebase = true
EOF

# Set up zsh configuration
cat > "${USER_HOME}/.zshrc" << 'EOF'
# Enable Oh My Zsh if available
if [ -f /run/current-system/sw/share/oh-my-zsh/oh-my-zsh.sh ]; then
    export ZSH=/run/current-system/sw/share/oh-my-zsh
    ZSH_THEME="robbyrussell"
    plugins=(git sudo docker kubectl)
    source $ZSH/oh-my-zsh.sh
fi

# Aliases
alias ll="ls -l"
alias la="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias grep="rg"
alias cat="bat"
alias ls="exa"

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${HOME}/.zsh_history"

# Enable autocompletion
autoload -U compinit
compinit

# Enable syntax highlighting if available
if [ -f /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Enable autosuggestions if available
if [ -f /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
EOF

echo "User dotfiles have been set up in ${USER_HOME}"
echo "Please restart your shell or run 'source ~/.zshrc' to apply zsh changes."
