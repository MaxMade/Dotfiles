# Dotfiles

Personal configs managed with [chezmoi](https://www.chezmoi.io/).

These dotfiles aim to provide a consistent, reproducible, and minimal setup across machines, with support for multiple window managers and tools.

**WARNING**: These configs are opinionated. Review before applying.

---

## Supported Programs

### Window Managers

#### Sway
- sway (Wayland compositor)
- waybar (status bar)
- swaync (notification center)

#### i3
- i3wm (X11 tiling window manager)
- i3status (status bar)
- dunst (notification daemon)

---

### Shell and CLI

- zsh (primary shell)
- bash (fallback shell)
- tmux (terminal multiplexer)
- starship (prompt)
- fzf (fuzzy search for history, files and directories)
- tig (git history browser)
- gdb (debugger)

---

### Editors

- helix (main editor)
- neovim (fallback editor)
- vim (fallback editor)

---

### Terminal

- alacritty

---

## Installation

### 1. Install chezmoi

Arch Linux:

```sh
pacman -S chezmoi
```

Debian, Ubuntu and other distributions:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

---

### 2. Install packages

Everything is optional. The shell configs skip tools that are not installed. Install what you need for the parts of the setup you want to use.

#### Arch Linux

Core:

```sh
pacman -S --needed git zsh bash tmux helix neovim vim fzf starship tig gdb gnupg pkgfile calc \
    zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
```

Terminal and fonts:

```sh
pacman -S --needed alacritty adobe-source-code-pro-fonts ttf-dejavu ttf-font-awesome noto-fonts
```

Sway (Wayland):

```sh
pacman -S --needed sway swaybg swayidle swaylock waybar swaync rofi wl-clipboard \
    brightnessctl playerctl pamixer pavucontrol libpulse alsa-utils
```

i3 (X11):

```sh
pacman -S --needed i3-wm i3status dunst dmenu rofi xorg-setxkbmap xautolock xclip \
    brightnessctl playerctl pamixer pavucontrol libpulse alsa-utils
```

Language servers for helix:

```sh
pacman -S --needed rust-analyzer clang texlab python-lsp-server bash-language-server tinymist
```

---

#### Debian

Core:

```sh
apt install git zsh bash tmux helix neovim vim fzf starship tig gdb gnupg apt-file calc \
    command-not-found zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
```

Terminal and fonts:

```sh
apt install alacritty fonts-adobe-sourcecodepro fonts-dejavu fonts-font-awesome fonts-noto
```

Sway (Wayland):

```sh
apt install sway swaybg swayidle swaylock waybar sway-notification-center rofi wl-clipboard \
    brightnessctl playerctl pamixer pavucontrol pulseaudio-utils alsa-utils
```

i3 (X11):

```sh
apt install i3 i3status dunst suckless-tools rofi x11-xkb-utils xautolock xclip \
    brightnessctl playerctl pamixer pavucontrol pulseaudio-utils alsa-utils
```

Language servers for helix:

```sh
apt install rust-analyzer clangd texlab python3-pylsp node-bash-language-server
```

---

#### Ubuntu

Core:

```sh
apt install git zsh bash tmux neovim vim fzf tig gdb gnupg apt-file calc \
    command-not-found zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
```

Terminal and fonts:

```sh
apt install alacritty fonts-adobe-sourcecodepro fonts-dejavu fonts-font-awesome fonts-noto
```

Sway (Wayland):

```sh
apt install sway swaybg swayidle swaylock waybar rofi wl-clipboard \
    brightnessctl playerctl pamixer pavucontrol pulseaudio-utils alsa-utils
```

i3 (X11):

```sh
apt install i3 i3status dunst suckless-tools rofi x11-xkb-utils xautolock xclip \
    brightnessctl playerctl pamixer pavucontrol pulseaudio-utils alsa-utils
```

Language servers for helix:

```sh
apt install clangd texlab python3-pylsp
```

Helix, starship and swaync are not available on every Ubuntu release:

```sh
snap install helix --classic
curl -sS https://starship.rs/install.sh | sh
```

---

### 3. Initialize dotfiles

```sh
chezmoi init https://github.com/MaxMade/Dotfiles.git
```

Chezmoi asks a few questions on the first run:

- Does the machine have a battery
- Default wired network interface
- Default wireless network interface
- Wayland session (empty means X11)

The answers are stored in `~/.config/chezmoi/chezmoi.toml` and used to render the templates for waybar, i3status and the environment.

---

### 4. Apply configuration

```sh
chezmoi apply
```

This also runs the install scripts, which need `git` and network access. They clone the alacritty themes and the gruvbox colorscheme for vim, and reload tmux if a session is running.

---

## Notes

- `~/.local/bin/pass-select` picks a password from a directory of `.gpg` files via `rofi` and `gpg`. It copies the result with `wl-copy`, `xclip` or `xsel` if `-c` is given.
- Neovim installs its plugins with lazy.nvim on first start.
- Package names may differ between releases.
