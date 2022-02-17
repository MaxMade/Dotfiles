# Dotfiles

My current working setup for the command line.

# Installation

To use the provided configuration files, the following packages must be
installed:

```sh
# Arch Linux
pacman -S calc gdb neovim readline tig tmux zsh gdb-dashboard fzf \
zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting
```

```sh
# Debian
apt install calc gdb readline-common tig tmux zsh fzf \
zsh-autosuggestions zsh-syntax-highlighting

# For neovim (version 0.5 or newer) the Experimental version must be installed
apt install -t experimental neovim

# For gdb-dashboard the Github version must be installed
curl -fLo /usr/share/gdb-dashboard/.gdbinit --create-dirs \
https://raw.githubusercontent.com/cyrus-and/gdb-dashboard/master/.gdbinit

# For zsh-history-substring-search the Github version must be installed
curl -fLo /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh --create-dirs \
https://raw.githubusercontent.com/zsh-users/zsh-history-substring-search/master/zsh-history-substring-search.zsh

```

The neovim setup depends on the [packer.nvim](https://github.com/wbthomason/packer.nvim)
plugin manager which can be installed as follows:

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

The tmux setup makes use of [tpm](https://github.com/tmux-plugins/tpm) which must be installed separately:
```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Beginning with version 0.5, neovim supports the language server protocol (LSP)
for programming language-specific features such as:

- Go to definition
- Completion
- Code Actions
- Function Signatures
- ...

Those language servers must be installed separately:

```sh
# Arch Linux
pacman -S clang
pacman -S python-lsp-server
pacman -S bash-language-server
pacman -S texlab
pacman -S gopls
pacman -S python-pyghdl

pacman -S vscode-html-languageserver vscode-css-languageserver vscode-json-languageserver
```

```sh
# Debian
apt install clang gopls
```

```sh
cd $JDTLS_HOME
wget wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-$VERSION.tar.gz
tar xvf jdt-language-server-$VERSION.tar.gz
rm -f jdt-language-server-$VERSION.tar.gz
```

# Environment

To setup environment correctly, the following exports must be added to `$HOME/.profile`.

```sh
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export TERM=xterm-256color
export EDITOR=nvim
export GO111MODULE=on
export JDTLS_HOME="$HOME/.local/share/jdtls"
```
