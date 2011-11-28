### Bash mods ###

# Search history on arrows
bind '"[A":history-search-backward'
bind '"[B":history-search-forward'


### Aliases & Functions ###

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

parse_git_branch() 
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

alias ls='ls -F --color=auto'
alias vi=vim
alias more='less'
alias rpush='rsync -avzL --exclude-from=.gitignore --exclude=.git --exclude=.gitignore'


### Environment ###

export CLICOLOR=1
export EDITOR=vim
export PS1="\u@\h \[\033[0;36m\]\w\[\033[0m\] \[\033[0;33m\]\$(type -t parse_git_branch > /dev/null && parse_git_branch)\[\033[0m\]% "


### Path ###

# User bin 
PATH="~/dev/bin:${PATH}"
PATH="~/local/bin:${PATH}"


### OS extensions ###

[ -r ~/.bashrc-osx ] && source ~/.bashrc-osx
[ -r ~/.bashrc-linux ] && source ~/.bashrc-linux
