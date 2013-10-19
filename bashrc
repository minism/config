### Functions

# Add a path to PATH or move existing to front of list
addpath()
{
    PATH=${PATH//":$1"/}    #delete any instances in the middle or at the end
    PATH=${PATH//"$1:"/}    #delete any instances at the beginning
    export PATH="$1:$PATH"  #prepend to beginning
}

# Prepend a timestamp to each line of stdin
timestamp()
{
    while read line
    do
        echo "[$(date +%H:%M:%S)] ${line}"
    done
}

# mkdirp and cd
cdp()
{
    mkdir -p $1;
    cd $1;
}

# Make a python directory (now with -p!!)
mkpydir()
{
    for dir in "$@"; do
        mkdir -p $dir;
        while [ "$dir" != "." ]; do
            touch $dir/__init__.py
            dir=$(dirname $dir);
        done
    done
}

# Cleanup setup.py files
pipclean()
{
    rm -rf build
    rm -rf dist
    rm -rf *.egg-info
}

# Rsync a git directory
gsync()
{
    rsync -avz --exclude-from=$1/.gitignore --exclude=$1/.git --exclude=.gitignore $@
}

# Useful screen: attach or create by name
scr()
{
    socket=$1
    shift
    screen -x -q -U -RR $socket $*
}

# Simple python HTTP server
serv()
{
    port=${1:-8000}
    python -m SimpleHTTPServer $port
}


### Prompt

# Returns "*" if the current git branch is dirty.
_parse_git_dirty()
{
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

# Get the current git branch name (if available)
_git_prompt()
{
    local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
    if [ "$ref" != "" ]; then
        echo "($ref$(_parse_git_dirty))"
    fi
}

# Get the current screen number
_screen_prompt()
{
  if [ "${WINDOW}" != "" ]; then
    echo "[$WINDOW] "
  fi
}

export PS1="\$(type -t _screen_prompt > /dev/null && _screen_prompt)\[\033[0;32m\]\u@\h\[\033[0m\] \[\033[0;36m\]\w\[\033[0m\] \[\033[0;33m\]\$(type -t _git_prompt > /dev/null && _git_prompt) \[\033[0;31m\]\[\033[0m\]% "


### Aliases

alias ls='ls -F --color=auto'
alias tree='tree -C'
alias vi=vim
alias py=python
alias less='less -R'
alias grep='egrep --color=auto'
alias jcurl='curl -H "Accept: application/json"'


### Environment

export CLICOLOR=1
export EDITOR=vim
export PYTHONSTARTUP="$HOME/.pystartup"
# export LUA_PATH="$HOME/local/lib/lua/?.lua;$HOME/local/lib/lua/?/init.lua"


### Paths

addpath ~/bin


# Load local extension, if it exists
[ -r ~/.bashrc_local ] && source ~/.bashrc_local
