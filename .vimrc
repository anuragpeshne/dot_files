syntax enable 
set shiftwidth=4
set tabstop=4
set autochdir

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'


call vundle#end()            " required
filetype plugin indent on    " required

if has("autocmd")
  filetype plugin indent on
endif

set foldenable

colorscheme wombat "solarized
set number
"set cursorline			this make vim ugly in some color schemes
filetype indent on
set wildmenu
set hlsearch
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching If you search for something containing uppercase characters, it will do a case sensitive search; if you search for something purely lowercase, it will do a case insensitive search. You can use \c and \C to override 
set incsearch           " Incremental search
set hidden              " Hide buffers when they are abandoned
autocmd VimEnter * NERDTree "open nerd on startup
autocmd VimEnter * wincmd p "have cursor in file editing tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif "close nerd tree if all other files are closed
