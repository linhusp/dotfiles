#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# NOTE: Run `dircolors -p > ~/.config/dircolors` to generate the colors
if [[ -f "$XDG_CONFIG_HOME/dircolors" ]]; then
    eval "$(dircolors -b "$XDG_CONFIG_HOME/dircolors")"
else
    # https://unix.stackexchange.com/questions/94498/what-causes-this-green-background-in-ls-output
    export LS_COLORS+=':ow=01;33'
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Run fish only for interactive session that is not already fish
if [[ $(ps --no-header --pid="$PPID" --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]; then
    if command -v fish >/dev/null 2>&1; then
        exec fish
    fi
fi
