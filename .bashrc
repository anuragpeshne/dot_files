# awesome git status
alias gits="git status -sb"

# colorify
alias grep="grep --color"
alias egrep="egrep --color=auto";
alias ls="ls -G"

# tmux with unicode support; Fixes funny whitespace prepended in commands
alias tmux="tmux -u"

# for OSX: point vim to newer version
alias vim="/Applications/MacVim.app/Contents/MacOS/vim"
alias mvim="/Applications/MacVim.app/Contents/MacOS/MacVim"

# scheme
alias scheme="/Applications/MIT\:GNU\ Scheme.app/Contents/Resources/mit-scheme"

export PS1="\w\[$(tput sgr0)\]\[\033[38;5;50m\][\$?\[$(tput sgr0)\]\[\033[38;5;86m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ "

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}
