set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set hlsearch                " highlight search set hlsearch
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbersset number
set wildmode=longest,list   " get bash-like tab completions
set cc=120                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlightingsyntax on
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spell                 " enable spell check (may need to download language package)
set backupdir=~/.cache/vim " Directory to store backup files.

set encoding=utf-8          " hopefully it does this on its own anyway?

set guifont=JetBrains\ Mono\ Nerd\ Font\ 20
let g:airline_powerline_fonts = 1

" ============= Plugins =================== "
call plug#begin("~/.vim/plugged")
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vim-airline/vim-airline'
call plug#end()

colorscheme catppuccin " Alternatives: catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha


" For Ocaml
set rtp^="/home/jakobteuber/.opam/5.0.0/share/ocp-indent/vim"


