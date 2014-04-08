filetype off        " disabled until Vundle loads

set shortmess+=I  	" disable welcome message
set number      		" enable line numbers
set backspace=2   	" Backspace deletes like most programs in insert mode
set nocompatible  	" Use Vim settings, rather then Vi settings
set cursorline      " highlight the current line
set hlsearch	    	" highlight searches
set ignorecase
set smartcase       " case insensitive search when no uppercase chars present
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

" When cycling throug words keep the current word in the middle
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv


"-----------------------------------------------------------------------------
" Indentation options

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab


" Centralized swap file location
if has("win32")
   set directory=c:\\temp
elseif has("unix")
   set directory=~/.vim-swap//
   set backupdir=~/.vim-backup//
endif




" Opens a split with F7 where the current ruby code is executed
function! Ruby_eval_vsplit() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":silent ! ruby " . src . " > " . dst . " 2>&1 "
  execute ":pclose!"
  execute ":redraw!"
  execute ":vsplit"
  execute "normal \<C-W>l"
  execute ":e! " . dst
  execute ":set pvw"
  execute "normal \<C-W>h"
endfunction
vmap <silent> <F7> :call Ruby_eval_vsplit()<CR>
nmap <silent> <F7> mzggVG<F7>`z
imap <silent> <F7> <Esc><F7>a
map <silent> <S-F7> <C-W>l:bw<CR>
imap <silent> <S-F7> <Esc><S-F7>a


