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

# awesome git status
alias gits="git status -sb"

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

   # scheme
   alias scheme="/Applications/MIT\:GNU\ Scheme.app/Contents/Resources/mit-scheme"
fi

# tmux with unicode support; Fixes funny whitespace prepended in commands
alias tmux="tmux -u"

# if we have sshed, then show hostname too;
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        export PS1="\[\033[48;5;12m\]\h\[$(tput sgr0)\]\[\033[48;5;-1m\]:\w\[$(tput sgr0)\]\[\033[38;5;50m\][\$?\[$(tput sgr0)\]\[\033[38;5;86m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ "
    else
        export PS1="\w\[$(tput sgr0)\]\[\033[38;5;50m\][\$?\[$(tput sgr0)\]\[\033[38;5;86m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ "
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
