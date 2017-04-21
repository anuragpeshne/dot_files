# colors
SH_WHITE="\[\033[1;37m\]"
SH_BLUE="\[\033[1;34m\]"
SH_RED="\[\033[1;31m\]"
SH_GREEN="\[\033[1;32m\]"
SH_YELLOW="\[\033[1;33m\]"

# determine platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
fi

# git aliases
alias gits="git status -sb"
alias gitc="git diff --name-only --diff-filter=U"

# colorify
alias grep="grep --color"
alias egrep="egrep --color=auto";
alias g11="clang++ -std=c++11 -stdlib=libc++ -Weverything"

if [[ $platform == 'linux' ]]; then
   alias ls='ls --color=auto'
elif [[ $platform == 'freebsd' ]]; then
   alias ls='ls -G'
elif [[ $platform == 'osx' ]]; then
   alias ls='ls -G'
   # for OSX: point vim to newer version
   alias vim="/Applications/MacVim.app/Contents/MacOS/vim"
   alias mvim="/Applications/MacVim.app/Contents/MacOS/MacVim"

   alias emacsc="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

   # scheme
   alias scheme="/Applications/MIT\:GNU\ Scheme.app/Contents/Resources/mit-scheme"
fi

# tmux with unicode support; Fixes funny whitespace prepended in commands
alias tmux="tmux -u"

# special functions for competitive programming
solve() {
  cp template.cpp $1
  vim +4 $1
}

# if we have sshed, then show hostname too;
export PS1="\w\[$(tput sgr0)\]"${SH_GREEN}"[\$?\[$(tput sgr0)\]"${SH_GREEN}"]\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ "
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        # sshed
        alias rm="rm -i" # are you sure you want to rm on sshed system?
        export PS1=${SH_BLUE}"\u@\H\[$(tput sgr0)\]"${PS1}
fi

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

if [ -x /usr/local/bin/fortune -o -x /usr/bin/fortune ]; then
    fortune
fi
