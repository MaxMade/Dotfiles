# Keybinding
bindkey -v
set -o vi
bindkey -M vicmd '^[[3~' delete-char
bindkey -M viins '^[[3~' delete-char
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1

# History file
HISTFILE=~/.zsh_history
setopt hist_ignore_all_dups
HISTSIZE=5000
SAVEHIST=5000

# Alias
alias ls="ls --color=auto --human-readable"
alias sl="ls --color=auto --human-readable"
alias la="ls --color=auto --human-readable -la"
alias xclip="xclip -selection clipboard"
alias ..="cd .."
alias .="termite . &"
alias less="less -r"
alias grep="grep --colour=always"
alias open="mimeopen"

# Tab completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Set default editor
export EDITOR=vim

# fzf
PATH_FZF="/usr/share/fzf/"
if [[ -f $PATH_FZF/key-bindings.zsh ]]; then
	source $PATH_FZF/key-bindings.zsh
fi

# Syntax highlighting
PATH_SYNTAX="/usr/share/zsh/plugins/zsh-syntax-highlighting/"
if [[ -f $PATH_SYNTAX/zsh-syntax-highlighting.zsh ]]; then
	source $PATH_SYNTAX/zsh-syntax-highlighting.zsh
fi

# Command not found hook
PATH_COMMAND="/usr/share/doc/pkgfile/"
if [[ -f $PATH_COMMAND/command-not-found.zsh ]]; then
	source $PATH_COMMAND/command-not-found.zsh
fi

# autosuggestions
PATH_AUTOSUGGEST="/usr/share/zsh/plugins/zsh-autosuggestions/"
if [[ -f $PATH_AUTOSUGGEST/zsh-autosuggestions.zsh ]]; then
	source $PATH_AUTOSUGGEST/zsh-autosuggestions.zsh

	bindkey -M vicmd '^@' autosuggest-execute
	bindkey -M viins '^@' autosuggest-execute

	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=16'

fi

# Substring cmd completion
PATH_SUBSTRING="/usr/share/zsh/plugins/zsh-history-substring-search/"
if [[ -f $PATH_SUBSTRING/zsh-history-substring-search.zsh ]]; then
	source $PATH_SUBSTRING/zsh-history-substring-search.zsh

	bindkey -M vicmd 'k' history-substring-search-up
	bindkey -M vicmd 'j' history-substring-search-down

	bindkey -M viins "^[k" history-substring-search-up
	bindkey -M viins "^[j" history-substring-search-down

	bindkey -M viins "^K" history-substring-search-up
	bindkey -M viins "^J" history-substring-search-down

	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none
	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=none
fi

# Functions
man() {
	LESS_TERMCAP_md=$'\e[01;31m'	          \
	LESS_TERMCAP_so=$'\e[48;5;3m\e[38;5;0m'   \
	LESS_TERMCAP_us=$'\e[01;32m'              \
	LESS_TERMCAP_me=$'\e[0m'                  \
	LESS_TERMCAP_se=$'\e[0m'                  \
	LESS_TERMCAP_ue=$'\e[0m'                  \
	command man "$@"
}

git() {
	if [ "$@[1]" = "graph" ]; then
		tig --all
	else
		command git "$@"
	fi
}

khal() {
	command rlwrap khal "$@"
}

# Prompt
autoload -U colors zsh/terminfo
autoload -Uz vcs_info

autoload -U colors && colors
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr '+'

# Information about branch, staged and changed files
setopt prompt_subst
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats "%F{yellow}(%b%u%c)%f "

## Update each time new prompt is rendered
precmd () {
	vcs_info
}

## Set the actual prompt as following (hosename underlined if ssh):
## user@hostname ~ echo 42            [0]
setprompt() {

	# user@
	PS1="%F{green}%n%f%F{blue}@%f"

	# hostname (underlinded if ssh)
	if [ -z "$SSH_TTY" ]; then
		PS1="$PS1%F{green}%M%f"
	else
		PS1="$PS1%F{green}%U%M%u%f"
	fi
	# ~
	PS1="$PS1 %F{blue}%2~%f "

	# VCS information
	PS1="$PS1\$vcs_info_msg_0_%F{green}»%f "

	# Exit status of last command
	RPS1="[%(?.%F{green}%?%f.%F{red}%?%f)]"
}
setprompt

# Set cursor shape depending on vi mode
zle -N zle-line-init
zle -N zle-keymap-select
function zle-line-init zle-keymap-select {
	if [ "$KEYMAP" = "vicmd" ]; then
		echo -ne '\e[1 q'
	else
		echo -ne '\e[5 q'
	fi
}


# start gpg/ssh agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye > /dev/null
export LC_CTYPE=en_US.UTF-8

# Exports
export TERM=xterm-256color
export PATH="${PATH}:$HOME/.bin"
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_CTRL_T_COMMAND="fd --hidden --exclude .git --exclude .cache"
export FZF_ALT_C_COMMAND="fd --hidden --type d --exclude .git --exclude .cache"
export FZF_DEFAULT_COMMAND="fd --type f --type l --hidden --exclude .git  --exclude .cache"
