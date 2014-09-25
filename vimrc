execute pathogen#infect()

set t_Co=256
set background=dark

set guioptions-=T  "remove toolbar

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

" Split pane business
set splitbelow
set splitright

" Status bar business
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

if has("autocmd")
	filetype on
	filetype plugin indent on

	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	autocmd FileType python setlocal expandtab
	autocmd FileType python let &colorcolumn=join(range(80,80),",")
endif

" It needs to be after filetype on for csv.vim
syntax on

" Always highlight unwanted spaces http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Define colour before colorscheme so it's not overriden
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Enable colorscheme
if has("gui_running")
	colorscheme desert
else
	colorscheme Tomorrow-Night-Bright
endif

" Save your swp files to a less annoying place than the current directory.
" " If you have .vim-swap in the current directory, it'll use that.
" " Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
	:silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

"""""""""" EXTERNAL PLUGINS THAT NEED INSTALLING

" Airline
let g:airline#extensions#tabline#enabled = 0 "Do not show all open buffers on top bar (that way tabs show fine)
let g:airline_theme='dark'

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" signify
let g:signify_vcs_list = ['git']

" tagbar
nmap <F8> :TagbarToggle<CR>

" syntastic
let g:syntastic_python_checkers = ['flake8', 'pep8']

" unite.vim (from John)
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

"""""""""" EXTERNAL PLUGINS, NAME + SOURCE

" https://github.com/bling/vim-airline				# airline
" https://github.com/tpope/vim-commentary			# commentary
" https://github.com/vim-scripts/csv.vim			# csv.vim
" https://github.com/tpope/vim-fugitive				# fugitive (git)
" https://github.com/nathanaelkane/vim-indent-guides# indent-guides(leaderig)
" https://github.com/michaeljsmith/vim-indent-object# indent-object
" https://github.com/davidhalter/jedi-vim.git		# jedi (pip install jedi)
" https://github.com/vim-scripts/The-NERD-tree.git	# nerdtree
" https://github.com/voithos/vim-python-matchit		# python-matchit
" https://github.com/kien/rainbow_parentheses.vim	# rainbow_parentheses
" https://github.com/mhinz/vim-signify				# signify
" https://github.com/tpope/vim-surround.git			# surround
" https://github.com/scrooloose/syntastic.git		# syntastic
" https://github.com/majutsushi/tagbar				# tagbar
" https://github.com/chriskempson/tomorrow-theme	# tomorrow-theme (copyfiles)
" https://github.com/Shougo/unite.vim				# unite
