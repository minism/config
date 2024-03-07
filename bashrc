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

# Open sublime text in a way that allows piping on linux.
sub()
{
  # Is stdin a terminal?
  if test -t 0; then
    # Stdin is a terminal.
    # Open sublime normally.
    subl -a "$@"
  else
    # Stdin is not a terminal, it must be a pipe.
    # Pipe stdin to a temporary file, and open it in sublime.
    FILENAME=$(tempfile)
    cat >"$FILENAME" && subl -a "$FILENAME" "$@"
  fi
}

scaffold-unity()
{
  if [ ! -d "Assets" ]; then
    echo "Expected Assets directory - run from Unity project root."
    return 1
  fi;

  for dir in Audio Imported Textures Scenes Sprites Shaders Materials Scripts Models Prefabs Settings; do
    mkdir -v -p "Assets/$dir"
  done
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
    local ref=$(git symbolic-ref HEAD 2>/dev/null | sed 's;refs/heads/;;g')
    if [ "$ref" != "" ]; then
        echo "($ref$(_parse_git_dirty)) "
    fi
}

# Get the current screen number
_screen_prompt()
{
  if [ "${WINDOW}" != "" ]; then
    echo "[$WINDOW] "
  fi
}

export PS1="[\D{%H:%M}] \$(type -t _screen_prompt > /dev/null && _screen_prompt)\[\033[0;32m\]\u@\h\[\033[0m\] \[\033[0;36m\]\w\[\033[0m\] \[\033[0;33m\]\$(type -t _git_prompt > /dev/null && _git_prompt)\[\033[0;31m\]\[\033[0m\]% "


### Aliases

alias grep='egrep --color=auto'
alias jcurl='curl -H "Accept: application/json"'
alias jsonsort='python -c "import sys,json; json.dump(json.load(sys.stdin), sys.stdout, indent=2, sort_keys=True)"'
alias less='less -R'
alias ls='ls -F --color=auto'
alias py=python
alias tree='tree -C'
alias vi=vim
alias xclip='xclip -selection c'


### Environment

export CLICOLOR=1
export EDITOR=vim
export PYTHONSTARTUP="$HOME/.pystartup"
export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip
# export LUA_PATH="$HOME/local/lib/lua/?.lua;$HOME/local/lib/lua/?/init.lua"

# Unlimited history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_infinite_history
export HISTCONTROL=ignorespace

# Single history view (append instead of overwrite)
shopt -s histappend

# Disable start/stop control so that C-s works for forward i search.
stty -ixon

# Apply history after every command rather than just exit
PROMPT_COMMAND='history -a; history -n'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi



### Paths

addpath ~/bin
addpath ~/dev/bin
addpath /usr/local/lib
addpath /usr/local/bin


### Nix shell settings.
NIX_SHELL_PRESERVE_PROMPT=1
if [[ -n "$IN_NIX_SHELL" ]]; then
  PS1="(nix-shell) $PS1"
fi


# Load local extension, if it exists
[ -r ~/.bashrc_local ] && source ~/.bashrc_local
