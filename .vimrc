" based on https://github.com/skwp/dotfiles/blob/master/vimrc

" The Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow
"overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
   source ~/.vimrc.before
endif

   " ================ General Config ====================

set relativenumber                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" :BundleInstall or :BundleUpdate
" from  https://github.com/skwp/dotfiles/blob/master/vim/vundles.vim
if filereadable(expand("~/.vim/vundles.vim"))
source ~/.vim/vundles.vim
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle "gmarik/vundle"

" All your bundles here

" General vim improvements
Bundle "scrooloose/nerdtree.git"
Bundle "scrooloose/syntastic.git"
Bundle "tpope/vim-repeat.git"
Bundle "tpope/vim-surround.git"

" Code improvements
Bundle 'taglist.vim'
Bundle 'kien/ctrlp.vim'

" JavaScript
Bundle "pangloss/vim-javascript"
" use npm install -g jshint if dont have jshint on system
Bundle "jshint2.vim"

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Toggle relative and absolute numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
noremap <C-n> :call NumberToggle()<cr>

imap jj <ESC>

" === Buffers ===
" easier for viewing buffer list
noremap <leader>l :ls<CR>
" stay on same buffer for CtrlP
let g:ctrlp_switch_buffer = 0

" === Windows ===
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" maximize window
noremap <leader>m <C-W>_

" Press Space to turn off highlighting and clear any message already displayed.
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
noremap <leader>l :ls<CR> "easier for viewing buffer list

" Windows gVim options
"set guioptions-=m "remove menu bar
"set guioptions-=T "remove tool bar
"set guioptions-=r "remove scroll bar
"set guifont=Consolas:h11:cDEFAULT "change default font for windows

"colorscheme solarized "best colorscheme (need to download)

set hlsearch
set ignorecase
set smartcase

