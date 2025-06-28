# Lightweight NixOS Configuration with Flakes and Home-Manager

This is a lightweight NixOS configuration that utilizes flakes and home-manager, inspired by the [librephoenix/nixos-config](https://github.com/librephoenix/nixos-config) repository but significantly simplified.

## Features

- **Flake-based configuration**: Modern, reproducible builds with dependency management
- **Home-Manager integration**: User-level package and configuration management
- **Lightweight setup**: Minimal configuration focusing on essential packages and settings
- **Modular design**: Easy to extend and customize
- **GNOME desktop environment**: Clean, user-friendly desktop setup
- **Development-ready**: Includes common development tools and terminal configurations

## Files Structure

```
.
├── flake.nix                 # Main flake configuration with inputs/outputs
├── configuration.nix         # System-level NixOS configuration
├── home.nix                  # User-level Home-Manager configuration
├── hardware-configuration.nix # Hardware-specific configuration (auto-generated)
├── install.sh               # Installation script
└── README.md                # This file
```

## Quick Start

### Prerequisites

- An existing NixOS installation
- Nix flakes enabled (the install script will check this)

### Installation

1. **Clone or download this configuration:**
   ```bash
   git clone <this-repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```

   The script will:
   - Generate your hardware configuration automatically
   - Prompt you to customize settings in `flake.nix`
   - Build and switch to the new NixOS configuration
   - Install and activate the Home-Manager configuration

### Manual Installation

If you prefer to install manually:

1. **Generate hardware configuration:**
   ```bash
   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```

2. **Edit `flake.nix` to customize your settings:**
   - Username, name, email
   - Hostname, timezone, locale
   - Any other personal preferences

3. **Build and switch NixOS configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#system
   ```

4. **Install Home-Manager configuration:**
   ```bash
   nix run home-manager/master -- switch --flake .#user
   ```

## Customization

### System Settings

Edit the `systemSettings` section in `flake.nix`:

```nix
systemSettings = {
  system = "x86_64-linux";
  hostname = "your-hostname";
  timezone = "Your/Timezone";
  locale = "en_US.UTF-8";
  bootMode = "uefi"; # or "bios"
  # ...
};
```

### User Settings

Edit the `userSettings` section in `flake.nix`:

```nix
userSettings = rec {
  username = "your-username";
  name = "Your Full Name";
  email = "your-email@example.com";
  shell = "zsh";
  editor = "vim";
  # ...
};
```

### Adding Packages

- **System packages**: Add to `environment.systemPackages` in `configuration.nix`
- **User packages**: Add to `home.packages` in `home.nix`

### Desktop Environment

The default configuration uses GNOME. To change this:

1. Edit `configuration.nix`
2. Replace the GNOME section with your preferred desktop environment
3. Update any related services and dependencies

## Included Software

### System Level
- Git, Vim, Wget, Curl
- Home-Manager
- GNOME Desktop Environment
- NetworkManager
- PipeWire audio system

### User Level
- Development tools: Git, Vim, Neovim
- Terminal: Alacritty with custom configuration
- Shell: Zsh with Oh-My-Zsh
- Utilities: htop, tree, ripgrep, bat, exa, ranger
- Web browser: Firefox

## Making Changes

After initial installation, to apply changes:

1. **Edit configuration files** as needed
2. **Rebuild system configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#system
   ```
3. **Update Home-Manager configuration:**
   ```bash
   home-manager switch --flake .#user
   ```

## Key Differences from librephoenix/nixos-config

This configuration is intentionally simplified:

- **Single profile**: No multiple profile system
- **Essential packages only**: Focused on core development tools
- **Simplified structure**: Fewer modules and abstractions
- **GNOME default**: Single desktop environment choice
- **Basic theming**: No complex styling system
- **Minimal modules**: Direct configuration instead of heavily modularized setup

## Extending the Configuration

This lightweight setup serves as a great starting point. You can extend it by:

- Adding more user modules from the original librephoenix config
- Implementing a profile system for different use cases
- Adding more desktop environments or window managers
- Incorporating styling systems like Stylix
- Adding development language-specific configurations

## Troubleshooting

### Flakes not enabled
If you get flake-related errors, ensure experimental features are enabled:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

### Home-Manager conflicts
If Home-Manager fails due to existing files, either:
- Back up and remove conflicting files
- Use `home-manager switch --flake .#user --backup-extension .bak`

### Hardware configuration issues
Make sure your `hardware-configuration.nix` is properly generated for your system:
```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

## Contributing

Feel free to submit issues and pull requests to improve this configuration!

## License

This configuration is provided as-is for educational and personal use.
My nixos configuartion.
