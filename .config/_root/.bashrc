###########
# ALIASES #
###########

# Directory stack aliases
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

alias ls='ls -F --color=auto'
alias vi=vim
alias more='less'
alias grep='grep --color=auto'


###############
# ENVIRONMENT #
###############

export CLICOLOR=1
export PS1='\u@\h:\w $ '
export EDITOR='vim'

########
# PATH #
########

# User bin PATH
PATH="~/bin:${PATH}"

########
# KEYS #
########
eval `keychain --quiet --eval --agents ssh id_rsa`

