# .bashrc


# BEGIN: Deafault Fedora config

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Custom Prompt
source ~/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_HIDE_IF_PWD_IGNORED="true"

eval "$(starship init bash)"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# Rust setup
. "$HOME/.cargo/env"

# Editors
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"


# My aliases
alias fd='cd "$(find ~/* -type d | fzf -i)"'
alias ssh-lx='ssh -c aes192-ctr lxhalle'
alias vi=nvim
alias vim=nvim
