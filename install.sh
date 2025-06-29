#!/usr/bin/env bash

# Simple NixOS installation script for this flake configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== NixOS Flake Configuration Setup ==="
echo "Script directory: $SCRIPT_DIR"

# Check if we're running on NixOS
if [ ! -f /etc/nixos/configuration.nix ]; then
    echo "Error: This script should be run on an existing NixOS installation."
    exit 1
fi

# Check if flakes are enabled
if ! nix --version &>/dev/null || ! nix flake --help &>/dev/null 2>&1; then
    echo "Error: Nix flakes are not available. Please enable experimental features first."
    echo "Add this to your current NixOS configuration:"
    echo "  nix.settings.experimental-features = [ \"nix-command\" \"flakes\" ];"
    echo "Then run: sudo nixos-rebuild switch"
    exit 1
fi

# Generate hardware configuration if it doesn't exist or is the template
if [ ! -f "$SCRIPT_DIR/hardware-configuration.nix" ] || grep -q "REPLACE-WITH-YOUR" "$SCRIPT_DIR/hardware-configuration.nix"; then
    echo "Generating hardware configuration..."
    sudo nixos-generate-config --show-hardware-config > "$SCRIPT_DIR/hardware-configuration.nix"
    echo "Hardware configuration generated successfully."
fi

# Prompt user to edit the flake.nix for personal settings
echo ""
echo "Before proceeding, you may want to edit the flake.nix file to customize:"
echo "  - Username (currently: 'user')"
echo "  - Name (currently: 'User')"
echo "  - Email (currently: 'user@example.com')"
echo "  - Hostname (currently: 'nixos')"
echo "  - Timezone (currently: 'UTC')"
echo ""
read -p "Do you want to edit flake.nix now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ${EDITOR:-nano} "$SCRIPT_DIR/flake.nix"
fi

echo ""
echo "Building and switching to the new NixOS configuration..."
sudo nixos-rebuild switch --flake "$SCRIPT_DIR#system"

echo ""
echo "Setting up user dotfiles..."
"$SCRIPT_DIR/setup-user-dotfiles.sh"

echo ""
echo "=== Installation Complete! ==="
echo "Your NixOS system has been configured with flakes (without home-manager)."
echo ""
echo "To make changes in the future:"
echo "  1. Edit the configuration files in $SCRIPT_DIR"
echo "  2. Run: sudo nixos-rebuild switch --flake $SCRIPT_DIR#system"
echo ""
echo "You may need to restart your shell or log out and back in for all changes to take effect."
