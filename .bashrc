# awesome git status
alias gits="git status -sb"

# highlight matches
alias grep="grep --color"
alias egrep="egrep --color=auto";

# tmux with unicode support; Fixes funny whitespace prepended in commands
alias tmux="tmux -u"

# custom programs 
alias resetPomo="ps -ae | grep '\d pomoDaemon' | awk '{print \$1}' | xargs kill -USR1";
