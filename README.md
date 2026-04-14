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

#### i3
- i3wm (X11 tiling window manager)
- i3status (status bar)

---

### Shell and CLI

- zsh (primary shell)
- bash (fallback shell)
- tmux (terminal multiplexer)

---

### Editors

- helix (main editor)
- vim (fallback editor)

---

## Installation

### 1. Install chezmoi

Linux (generic):

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

Arch Linux:

```sh
pacman -S chezmoi
```

---

### 2. Initialize dotfiles

```sh
chezmoi init https://github.com/MaxMade/Dotfiles.git
```

---

### 3. Apply configuration

```sh
chezmoi apply
```
