# htop
alias top='htop -t'

# vim
export EDITOR='vim'

# lla
alias lsa="lla"
alias ls="lla --no-dotfiles"

# trash-cli
alias rm='trash-put'

# yazi
function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias yazi='yz'

# x-cmd
alias wkp='x wkp'
alias ping='x ping'
alias gotop='x gotop'
alias vhs='x vhs'
alias proxy='x proxy'
