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
" Bundle 'tpope/vim-bundler'    " Slow for some reason
Bundle 'tpope/vim-surround'
Bundle 'ngmy/vim-rubocop'

Bundle 'tpope/vim-commentary'

Bundle 'wannesm/wmgraphviz.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-haml'
Bundle 'elzr/vim-json'
Bundle 'josemarluedke/vim-rspec'
Bundle 'godlygeek/tabular'

" Ruby block support (every block delimited by 'end')
Bundle 'tmhedberg/matchit'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

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

" Ctrl p fuzzy finding include .files
let g:ctrlp_show_hidden = 0

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

" I18n vim surround extraction
" i key
autocmd FileType eruby let b:surround_105 = "<%= t('\1key: \1', %{\r}) %>"
" o key
autocmd FileType eruby let b:surround_111 = "t('\1key: \1', \r)"
autocmd FileType ruby let b:surround_111 = "t('\1key: \1', \r)"


" Powerline scripts
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim


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

" Enable matchit plugin
runtime macros/matchit.vim
if has("autocmd")
  filetype indent plugin on
endif

" Yank and paste from the Mac clipboard
set clipboard=unnamed

