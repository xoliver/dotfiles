execute pathogen#infect()

set history=700
set wildmenu	"Activate showing autocomplete menu
set wildmode=longest,list,full	"Autocomplete as much as possible, do not go over options

" Search business
set ignorecase
set hlsearch
set incsearch

set showmatch		" Show matching brackets.

set magic
syntax enable

"Tab business
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set noexpandtab

set number

" Fold business
set foldmethod=indent
set foldlevel=99

colorscheme desert

" Status bar business
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

if has("autocmd")
	filetype on
	filetype plugin indent on

	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	autocmd FileType python setlocal expandtab
	autocmd FileType python let &colorcolumn=join(range(80,80),",") "Add red line at column 80 for python files
	" autocmd FileType csv CSVHeader 1
endif

" It needs to be after filetype on for csv.vim
syntax on

" EXTERNAL PLUGINS THAT NEED INSTALLING

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'

" signify
let g:signify_vcs_list = ['git']

" Unite.vim (from John)
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g  --ignore=htmlcov""'
call unite#filters#matcher_default#use(['matcher_fuzzy'])  " Use fuzzy matching
nmap <leader>p :Unite -no-split -start-insert file_rec<cr>
nmap <leader>l :Unite -no-split buffer<cr>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <silent><buffer><expr> <C-v> unite#do_action('right')
    imap <buffer> <C-j> <C-n>
    imap <buffer> <C-k> <C-p>
endfunction

" tagbar
nmap <F8> :TagbarToggle<CR>

" syntastic
let g:syntastic_python_checkers = ['flake8', 'pep8']

" STUFF
" csv.vim
" jedi-vim
" nerdtree
" supertab
" syntastic
" tagbar
" tomorrow-theme?
" unite.vim
" vim-airline
" vim-commentary
" vim-indent-object
" vim-signify
" vim-surround
"
" https://github.com/vim-scripts/csv.vim
" https://github.com/davidhalter/jedi-vim.git -> pip install vim
" https://github.com/vim-scripts/The-NERD-tree.git
" https://github.com/ervandew/supertab.git
" https://github.com/scrooloose/syntastic.git
" git://github.com/majutsushi/tagbar
" https://github.com/Shougo/unite.vim
" https://github.com/bling/vim-airline
" https://github.com/tpope/vim-commentary
" http://github.com/michaeljsmith/vim-indent-object
" https://github.com/mhinz/vim-signify
" git://github.com/tpope/vim-surround.git
