###################
# Key Definitions #
###################

typeset -g -A key
key[Backspace]="^?"
key[Delete]="^[[3~"
key[Ctrl-Space]="^@"
key[Ctrl-k]="^K"
key[Ctrl-j]="^J"

##############
# Keybinding #
##############

# Use vi Mode
bindkey -v
set -o vi

# Delete
bindkey -M vicmd -- "${key[Delete]}" delete-char
bindkey -M viins -- "${key[Delete]}" delete-char

# Backspace
bindkey -M vicmd -- "${key[Backspace]}" backward-delete-char
bindkey -M viins -- "${key[Backspace]}" backward-delete-char

export KEYTIMEOUT=1

################
# History file #
################

HISTFILE=~/.zsh_history
setopt hist_ignore_all_dups
HISTSIZE=10000
SAVEHIST=10000

#########
# Alias #
#########

alias ls="ls --color=auto --human-readable"
alias sl="ls --color=auto --human-readable"
alias la="ls --color=auto --human-readable -la"
alias xclip="xclip -selection clipboard"
alias ..="cd .."
alias less="less -r"
alias cgrep="grep --colour=always"
alias open="mimeopen"

##################
# Tab Completion #
##################

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

###########
# Plugins #
###########

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

# Autosuggestions
PATH_AUTOSUGGEST="/usr/share/zsh/plugins/zsh-autosuggestions/"
if [[ -f $PATH_AUTOSUGGEST/zsh-autosuggestions.zsh ]]; then
	source $PATH_AUTOSUGGEST/zsh-autosuggestions.zsh

	bindkey -M vicmd -- "${key[Ctrl-Space]}" autosuggest-execute
	bindkey -M viins -- "${key[Ctrl-Space]}" autosuggest-execute

	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#666666'
fi

# Substring cmd completion
PATH_SUBSTRING="/usr/share/zsh/plugins/zsh-history-substring-search/"
if [[ -f $PATH_SUBSTRING/zsh-history-substring-search.zsh ]]; then
	source $PATH_SUBSTRING/zsh-history-substring-search.zsh

	bindkey -M vicmd 'k' history-substring-search-up
	bindkey -M vicmd 'j' history-substring-search-down

	bindkey -M viins -- "${key[Ctrl-k]}" history-substring-search-up
	bindkey -M vicmd -- "${key[Ctrl-k]}" history-substring-search-up
	bindkey -M viins -- "${key[Ctrl-j]}" history-substring-search-down
	bindkey -M vicmd -- "${key[Ctrl-j]}" history-substring-search-down

	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none
	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=none
else
	bindkey "${key[Ctrl-k]}" history-search-backward
	bindkey "${key[Ctrl-j]}" history-search-forward
fi

#############
# Functions #
#############

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

##########
# Prompt #
##########

autoload -U colors zsh/terminfo
autoload -Uz vcs_info

# autoload -U colors && colors
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

# Set the actual prompt as following (hostname underlined if ssh):
# user@hostname ~ echo 42            [0]
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
	PS1="$PS1\$vcs_info_msg_0_%F{green}$%f "

	# Exit status of last command
	RPS1="[%(?.%F{green}%?%f.%F{red}%?%f)]"
}
setprompt

################
# Cursor Shape #
################

zle -N zle-line-init
zle -N zle-keymap-select
function zle-line-init zle-keymap-select {
	if [[ "$KEYMAP" = "vicmd" ]]; then
		echo -ne '\e[1 q'
	else
		echo -ne '\e[5 q'
	fi
}
