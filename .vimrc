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
set so=7 " always keep at least 7 lines of context when scrolling
set showmatch " show matching brackets when cursor is over them

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Turn mouse usage on
set mouse=a

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
"
" $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" $ vim +PluginInstall +qall
if filereadable(expand("~/.vim/vundles.vim"))
source ~/.vim/vundles.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle (required)
Plugin 'gmarik/Vundle.vim'

" All your bundles here

" General vim improvements
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-airline'

Plugin 'altercation/vim-colors-solarized'
Plugin 'rizzatti/dash.vim'

Plugin 'L9'
Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/neocomplcache.git'

" Code improvements
Plugin 'taglist.vim'
Plugin 'vim-scripts/CCTree'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'rking/ag.vim'

" JavaScript
Plugin 'pangloss/vim-javascript'
" use npm install -g jshint if dont have jshint on system
Plugin 'jshint2.vim'
Plugin 'kchmck/vim-coffee-script'

" Python
Plugin 'klen/python-mode'

" Salt
Plugin 'saltstack/salt-vim'

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

call vundle#end()
filetype plugin indent on

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

function! LeadingSpaceToTab()
  set noexpandtab
  :%retab!
  set expandtab
endfunc
noremap <leader>tt :call LeadingSpaceToTab()<CR>

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" Press Space to turn off highlighting and clear any message already displayed.
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

imap jj <ESC>

" === Buffers ===
"easier for viewing buffer list
noremap <leader>l :ls<CR>
" stay on same buffer for CtrlP
let g:ctrlp_switch_buffer = 0

" Don't switch working directory when invoked
let g:ctrlp_working_path_mode = 0

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" === Windows ===
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"maximize window
noremap <leader>m <C-W>_
"close window
noremap <leader>q <C-W>q

" ================ open NERDTree drawer ===============
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :TlistOpen<CR>

" ================ vim fugitive bindings ==============
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gb :Gblame<cr>

" ================ Dash search bindings ==============
nmap <silent> <leader>k <Plug>DashSearch

" ================ vim airline config ==============
set encoding=utf-8
set laststatus=2

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'powerlineish'
    for colors in values(a:palette.inactive)
      let colors[3] = 245
    endfor
  endif
endfunction

let g:airline_theme = 'powerlineish'
" let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif

set t_Co=256

" Windows gVim options
"set guioptions-=m "remove menu bar
"set guioptions-=T "remove tool bar
"set guioptions-=r "remove scroll bar
"set guifont=Consolas:h11:cDEFAULT "change default font for windows

" colorscheme solarized "best colorscheme (need to download)

set background=dark
set ignorecase smartcase
set hlsearch
set incsearch
set ignorecase
set smartcase

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Python Mode settings
"let g:pymode_lint_write = 0       "turn off running pylint on file save
"let g:pymode_lint_signs = 0
let g:pymode_rope = 0
nnoremap <leader>p :PyLint<cr>    "pressing ,p will run plyint on current buffer

let g:syntastic_enable_highlighting = 0

autocmd BufEnter,BufNew *.sls setlocal filetype=sls
autocmd BufEnter,BufNew *.coffee setlocal filetype=coffee
autocmd BufEnter,BufNew *.html setlocal shiftwidth=2 tabstop=2 softtabstop=2
