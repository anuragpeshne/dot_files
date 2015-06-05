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
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required

if has("autocmd")
  filetype plugin indent on
endif

set foldenable

set background=dark
colorscheme wombat256mod "solarized
set number
set relativenumber		" show linenumbers relative to current line
set cursorline
filetype indent on
set wildmenu
set hlsearch
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching; Use \c and \C to override
set incsearch           " Incremental search
set hidden              " Hide buffers when they are abandoned
set laststatus=2
set colorcolumn=80

" custom mapping
command Fo execute "normal! $zf%" " fold line by doing a :Fo
nnoremap <tab> :tabn<cr>
