# awesome git status
alias gits="git status -sb"

# colorify
alias grep="grep --color"
alias egrep="egrep --color=auto";
alias ls="ls -G"

# tmux with unicode support; Fixes funny whitespace prepended in commands
alias tmux="tmux -u"

# for OSX: point vim to newer version
alias mvim="/Applications/MacVim.app/Contents/MacOS/MacVim"
# neovim
alias vim="~/code/neovim/bin/nvim"

# scheme
alias scheme="/Applications/MIT\:GNU\ Scheme.app/Contents/Resources/mit-scheme"

export PS1="\w\[$(tput sgr0)\]\[\033[38;5;50m\][\$?\[$(tput sgr0)\]\[\033[38;5;86m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ "
