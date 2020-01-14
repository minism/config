set expandtab
set autoindent
set smarttab
set number
set tabstop=4 shiftwidth=4
set mouse=a
retab

syntax on

map , <<
map . >>
vmap , <<
vmap . >>

if filereadable(expand('~/.vimrc_local'))
	so ~/.vimrc_local
endif

if exists("*pathogen#infect")
    execute pathogen#infect()
    filetype plugin indent on
    map <f2> :NERDTreeToggle<CR>
endif

