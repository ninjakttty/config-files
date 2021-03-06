
################################################################################
# Using TMUX
function tnew()
{
    windows_name=$1
    tmux new -s $windows_name
}
alias tn="tnew"

function tlist()
{
    tmux ls
}
alias tl="tlist"

function tenter()
{
    windows_name=$1
    tmux attach -t $windows_name
}
alias te="tenter"

alias tw="tmux list-windows -a"

function t()
{
    _current_screen_list=$(tlist | sed 's/:/ /g' | awk '{print $1}')

    if [ -z "$1" ]
    then
        tlist
    elif [[ $_current_screen_list == *"$1"* ]];
    then
        echo "Let's open existing screen"
        tenter $1
    else
        echo "Let's create a new screen"
        tnew $1
    fi
}

_tenter()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    _current_windows=$(tlist | sed 's/:/ /g' | awk '{print $1}')
    COMPREPLY=( $(compgen -W "${_current_windows}" -- ${cur}) )
    return 0
}
complete -F _tenter tenter
complete -F _tenter te
complete -F _tenter t

alias treload-conf="tmux source-file ~/.tmux.conf"

# TODO
# Study code from https://gist.githubusercontent.com/ttscoff/a37427a8c331f072904d/raw/968192d7d0aabcde280155d0872dfa8cd8270619/tmux.bash

################################################################################
# Using Screen

function sname()
{
    echo "Current screen is called: "$STY
}

function ss()
{
    if [ -z "$1" ]
    then
        screen_name=$(basename $PWD)
    else
        screen_name=$1
    fi

    screen_name=$(echo $screen_name | tr '[:upper:]' '[:lower:]')

    screen -S $screen_name
}

function squit()
{
    # Screen Kill

    target_session=$(screen -list | grep $1 | awk '{print $1}' | head -1)

    screen -X -S ${target_session} quit

    echo "session "${target_session}" was killed!"
}

function open_screen()
{
    if [ -z "$1" ]
    then
        screen_name=$(sl | grep "(Detached)" | rev | cut -c12- | rev | awk '{print $1}' | sk)
    else
        screen_name=$1
    fi

    screen -r ${screen_name}
}
alias sr='open_screen'

alias sl='screen -list'
alias swipe='screen -wipe'
