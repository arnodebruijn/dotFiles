filetype off        " disabled until Vundle loads

set shortmess+=I  	" disable welcome message
set number      		" enable line numbers
set backspace=2   	" Backspace deletes like most programs in insert mode
set nocompatible  	" Use Vim settings, rather then Vi settings
set cursorline      " highlight the current line
set hlsearch	    	" highlight searches
set mouse=a		      " enable the use of the mouse for all modes
set cmdheight=1 	  " command windows height

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


" Bundles go here
Bundle 'altercation/vim-colors-solarized'
Bundle 'christoomey/vim-tmux-navigator'
"Bundle 'bling/vim-airline'

filetype plugin indent on     " enable after Vundle loads
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.


" Solarized colors
syntax on
set t_Co=256
set background=dark
colorscheme solarized
call togglebg#map("<F5>")


" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" More natural split opening
set splitbelow
set splitright


"set term=xterm		"to enable mouse scrolling via putty


"-----------------------------------------------------------------------------
" Indentation options

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

