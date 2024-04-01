set nocompatible  	      " use Vim settings, rather then Vi settings
filetype off        	    " disabled until Pathogen loads
set shortmess+=I  	      " disable welcome message
set number      	        " enable line numbers
set backspace=2   	      " Backspace deletes like most programs in insert mode
set cursorline         	  " highlight the current line
set hlsearch	      	    " highlight searches
set ignorecase            " ignore case while searching
set smartcase         	  " case insensitive search when no uppercase chars present
set incsearch             " incremental search: show where the pattern matches
set cmdheight=1   	      " command windows height
set statusline+=%F  	    " add full file path to your existing statusline
set mouse+=a		          " enable the use of the mouse for all modes
set term=xterm-256color	  " enable mouse scrolling via putty
set laststatus=2          " always display status line
set diffopt+=vertical 	  " open splits vertical
set wrap

"call pathogen#infect()
"call pathogen#helptags()
"filetype plugin indent on

" Solarized colors
syntax on
set t_Co=256
set background=dark
"colorscheme solarized

" Enable paste toggle and map it to F8
set pastetoggle=<F8>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" More natural split opening
set splitbelow

" When cycling throug words keep the current word in the middle
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Centralized swap file location
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Automatically turn on spell-checking
set spelllang=en
hi clear SpellBad
hi SpellBad cterm=underline
autocmd BufRead,BufNewFile *.md setlocal spell

" Easy playback of recordings in q register
:noremap Q @q

" netrw settings
let g:netrw_banner = 0
let g:netrw_altfile = 1

" Do bash like file completion for file names
set wildmode=longest,list

"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
"let g:powerline_pycmd = 'py3'
"let g:powerline_pycmd = 'py3eval'

" let g:pymode_python = 'python3'  " Python-mode python3 syntax
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 0
set foldmethod=indent
set foldlevelstart=2
set foldnestmax=2
:nnoremap <space> za
:vnoremap <space> zf

nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"set omnifunc=syntaxcomplete#Complete


" Remove when solarized colors are fixed
hi CursorLine   cterm=NONE ctermbg=0 ctermfg=NONE

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" nnoremap <C-w>h <C-h>
" nnoremap <C-w>j <C-j>
" nnoremap <C-w>k <C-k>
" nnoremap <C-w>l <C-l>
