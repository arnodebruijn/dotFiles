filetype off        " disabled until Vundle loads

" Seems to cause problems with Gdiff
" autocmd BufEnter * lcd %:p:h      "set the working directory to that of the current file

set shortmess+=I  	" disable welcome message
set number      		" enable line numbers
set backspace=2   	" Backspace deletes like most programs in insert mode
set nocompatible  	" Use Vim settings, rather then Vi settings
set cursorline      " highlight the current line
set hlsearch	    	" highlight searches
set ignorecase
set smartcase       " case insensitive search when no uppercase chars present
set cmdheight=1 	  " command windows height
set statusline+=%F  " Add full file path to your existing statusline
set mouse+=a		    " enable the use of the mouse for all modes
set term=xterm-256color		"to enable mouse scrolling via putty
set laststatus=2
set diffopt+=vertical " Open splits vertical


" Enable CTags
set tags+=gems.tags


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles go here
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'    " Slow for some reason
Plugin 'tpope/vim-surround'
Plugin 'ngmy/vim-rubocop'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-haml'
Plugin 'elzr/vim-json'
Plugin 'josemarluedke/vim-rspec'
Plugin 'godlygeek/tabular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

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

" Display extra whitespace
"set list listchars=tab:»·,trail:·

" Centralized swap file location
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

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
" Show hidden files in NERDTree
let NERDTreeShowHidden=1
