set history=700
set wildmenu
set wildmode=longest,list,full

set ignorecase
set hlsearch
set incsearch

set magic
syntax enable

autocmd FileType java setlocal noexpandtab smarttab

set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set noexpandtab

if has("autocmd")
	filetype on
	filetype plugin indent on

	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	autocmd FileType python setlocal expandtab
endif

set showmatch		" Show matching brackets.
