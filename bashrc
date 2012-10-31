### Bash mods ###

# Search history on arrows
bind '"[A":history-search-backward'
bind '"[B":history-search-forward'


### Functions ###

# Push directory
cd()
{
    if [ -z "$@" ] ; 
    then
        builtin pushd $HOME > /dev/null
    else
        builtin pushd "$@" > /dev/null
    fi  
}

# Pop to directory
p()
{
    builtin popd "$@" > /dev/null
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
    mkdir -p $1;
    dir=$1
    while [ "$dir" != "." ]; do
        touch $dir/__init__.py
        dir=$(dirname $dir);
    done
}


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
        echo "($ref$(_parse_git_dirty)) "
    fi
}


# Delete remote branches that have been merged in 
git-prune-remote()
{
    base=$1||"master"
    git branch -r --merged ${base} | sed 's/ *origin\///' | grep -v '${base}$' | xargs -I% git push origin :%
}


# Get the current screen number
_screen_prompt()
{
  if [ "${WINDOW}" != "" ]; then
    echo "[$WINDOW] "
  fi
}


# Add a path to PATH or move existing to front of list
addpath()
{
    PATH=${PATH//":$1"/}    #delete any instances in the middle or at the end
    PATH=${PATH//"$1:"/}    #delete any instances at the beginning
    export PATH="$1:$PATH"  #prepend to beginning
}


# Connect to remote irssi screen (or create a new one)
irc()
{
    ssh edgar -t "screen -D -RR -S irssi irssi"
}


# Rsync a git directory
gsync()
{
    dir=$1
    rsync -avz --exclude-from=$1/.gitignore --exclude=$1/.git --exclude=.gitignore $@
}



### Aliases ###

alias ls='ls -F --color=auto'
alias tree='tree -C'
alias vi=vim
alias py=python
alias more='less'
alias pytest='python setup.py -q install && '
alias jcurl='curl -H "Accept: application/json"'
alias tmpenv='rm -rf /tmp/tmpenv && virtualenv /tmp/tmpenv && source /tmp/tmpenv/bin/activate'
alias grep='egrep --color=auto'
alias mtime='stat -f %m'



### Environment ###

export CLICOLOR=1
export EDITOR=vim
export PS1="\$(type -t _screen_prompt > /dev/null && _screen_prompt)\[\033[0;32m\]\u@\h\[\033[0m\] \[\033[0;36m\]\w\[\033[0m\] \[\033[0;33m\]\$(type -t _git_prompt > /dev/null && _git_prompt)\[\033[0;31m\]\[\033[0m\]% "
export PATH
export PYTHONSTARTUP="$HOME/.pystartup"
# export LUA_PATH="$HOME/local/lib/lua/?.lua;$HOME/local/lib/lua/?/init.lua"



### Paths ###

addpath ~/dev/bin
addpath ~/local/bin
addpath /usr/local/bin
addpath /usr/local/sbin


### Load OS extensions ###

[ -r ~/.bashrc-osx ] && source ~/.bashrc-osx
[ -r ~/.bashrc-linux ] && source ~/.bashrc-linux
[ -r ~/.bashrc-local ] && source ~/.bashrc-local
