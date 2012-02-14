### Bash mods ###

# Search history on arrows
bind '"[A":history-search-backward'
bind '"[B":history-search-forward'


### Functions ###

# Directory stack
cd()
{
    if [ -z "$@" ] ; 
    then
        builtin pushd $HOME > /dev/null
    else
        builtin pushd "$@" > /dev/null
    fi  
}

p()
{
    builtin popd "$@" > /dev/null
}

# Immediate cd to new dir
cdp()
{
    mkdir -p $1;
    cd $1;
}

# Returns "*" if the current git branch is dirty.
function parse_git_dirty 
{
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

# Get the current git branch name (if available)
git_prompt() 
{
  local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
  if [ "$ref" != "" ]
  then
    echo "($ref$(parse_git_dirty)) "
  fi
}

# Add a path to PATH if it doesn't already exist
addpath ()
{
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

### Aliases ###

alias ls='ls -F --color=auto'
alias vi=vim
alias py=python
alias more='less'
alias rpush='rsync -avzL --exclude-from=.gitignore --exclude=.git --exclude=.gitignore'
alias pytest='python setup.py -q install && '


### Environment ###

export CLICOLOR=1
export EDITOR=vim
export PS1="\[\033[0;32m\]\u@\h\[\033[0m\] \[\033[0;36m\]\w\[\033[0m\] \[\033[0;33m\]\$(type -t git_prompt > /dev/null && git_prompt)\[\033[0;31m\]\[\033[0m\]% "
export PATH


### Path ###

addpath ~/dev/bin
addpath ~/local/bin
addpath /usr/local/bin
addpath /usr/local/sbin


### Load OS extensions ###

[ -r ~/.bashrc-osx ] && source ~/.bashrc-osx
[ -r ~/.bashrc-linux ] && source ~/.bashrc-linux
[ -r ~/.bashrc-local ] && source ~/.bashrc-local
