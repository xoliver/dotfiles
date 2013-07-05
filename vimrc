set history=700
filetype plugin on
filetype indent on
set wildmenu

set ignorecase
set hlsearch
set incsearch

set magic
syntax enable

autocmd FileType java setlocal noexpandtab smarttab

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
  filetype plugin indent on
endif

set showmatch		" Show matching brackets.
