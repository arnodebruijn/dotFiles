filetype off        " disabled until Vundle loads

" Seems to cause problems with Gdiff
" autocmd BufEnter * lcd %:p:h      "set the working directory to that of the current file

set regexpengine=1  " Use the new regex engine for improved performance
set nocursorcolumn      " Don't paint cursor column
set lazyredraw          " Wait to redraw
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let html_no_rendering=2 " Don't render italic, bold, links in HTML

set shortmess+=I  	" disable welcome message
set number      		" enable line numbers
set backspace=2   	" Backspace deletes like most programs in insert mode
set nocompatible  	" Use Vim settings, rather then Vi settings
set cursorline      " highlight the current line
set hlsearch	    	" highlight searches
set ignorecase
set smartcase       " case insensitive search when no uppercase chars present
set cmdheight=1 	  " command windows height
" set statusline+=%F  " Add full file path to your existing statusline
set mouse+=a        " enable the use of the mouse for all modes
set term=xterm-256color		"to enable mouse scrolling via putty
set laststatus=2
set diffopt+=vertical " Open splits vertical


" Enable CTags
set tags+=gems.tags

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
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-surround'
Bundle 'ngmy/vim-rubocop'

" Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-commentary'

Bundle 'wannesm/wmgraphviz.vim'
" Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-haml'
Bundle 'elzr/vim-json'
" Bundle 'godlygeek/tabular'

" Ruby block support (every block delimited by 'end')
Bundle 'tmhedberg/matchit'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

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
else
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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" NERDTree
map <C-n> :NERDTreeToggle <CR>
let NERDTreeWinSize = 50

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


" Powerline sripts
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Provide :Rfactory to open factory of current file
let g:rails_projections = {
  \  "spec/factories/*.rb": {
  \    "command": "factory",
  \    "affinity": "collection",
  \    "alternate": "app/models/%i.rb",
  \    "related": "db/schema.rb#%s",
  \    "spec": "spec/models/%i_spec.rb",
  \    "template": "FactoryGirl.define do\n  factory :%i do\n  end\nend",
  \    "keywords": "factory sequence"}}


" Highlight current file in NERDTree
map <leader>r :NERDTreeFind<cr>


" Enable matchit plugin
runtime macros/matchit.vim
if has("autocmd")
  filetype indent plugin on
endif

" Yank and paste from the Mac clipboard
set clipboard=unnamed
