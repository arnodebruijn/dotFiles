filetype off        " disabled until Vundle loads

set shortmess+=I  	" disable welcome message
set number      		" enable line numbers
set backspace=2   	" Backspace deletes like most programs in insert mode
set nocompatible  	" Use Vim settings, rather then Vi settings
set cursorline      " highlight the current line
set hlsearch	    	" highlight searches
set ignorecase
set smartcase       " case insensitive search when no uppercase chars present
set mouse+=a		    " enable the use of the mouse for all modes
set cmdheight=1 	  " command windows height
" set statusline+=%F  " Add full file path to your existing statusline
let g:airline_powerline_fonts = 1
set laststatus=2
set term=xterm-256color		"to enable mouse scrolling via putty

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'gmarik/Vundle.vim'

" Bundles go here
Bundle 'altercation/vim-colors-solarized'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'scrooloose/nerdtree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-surround'
Bundle 'jiangmiao/auto-pairs'
Bundle 'tomtom/tcomment_vim'
" Bundle 'jistr/vim-nerdtree-tabs'
" Bundle 'bling/vim-airline'
" Bundle 'edkolev/tmuxline.vim'

filetype plugin indent on     " enable after Vundle loads
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles


" Solarized colors
syntax on
set t_Co=256
set background=dark
colorscheme solarized

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Leet navigation
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Enable paste toggle and map it to F8
set pastetoggle=<F8>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

set omnifunc=syntaxcomplete#Complete
" More natural split opening
set splitbelow
set splitright

" When cycling throug words keep the current word in the middle
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Ctrl p fuzzy finding include .files
let g:ctrlp_show_hidden = 0

" Display extra whitespace
"set list listchars=tab:»·,trail:·

" Centralized swap file location
if has("win32")
   set directory=c:\\temp
elseif has("unix")
   set directory=~/.vim/swap//
   set backupdir=~/.vim/backup//
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


" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeWinSize = 50
let g:NERDTreeWinPos = "right"

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()



python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
