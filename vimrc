set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" mkdir -p ~/.vim/bundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim +PluginInstall +qall
Plugin 'gmarik/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'guns/vim-clojure-static.git'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/csv.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'elzr/vim-json.git'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'voithos/vim-python-matchit'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-unimpaired'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/vimproc.vim'  "Must recompile with make -f make_mac.mak in folder!!
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'  "Required by vim-easytags
Plugin 'tpope/vim-repeat'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets' "Rquired by ultisnips


" Download and install this into your ~/.vim/colors :
" https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Bright.vim
call vundle#end()
filetype plugin indent on

set t_Co=256
set background=dark
set clipboard=unnamed  "Enable copy-paste through tmux

set confirm  "Confirm when switching away from unsaved tab

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

" ctags business
set tags=./tags;

" Status bar business
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

if has("autocmd")
	filetype on
	filetype plugin indent on

	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	autocmd FileType python setlocal expandtab
	autocmd FileType python let &colorcolumn=join(range(80,100),",")
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

" Make the folder explorer look nicer
let g:netrw_liststyle=3

" Enable colorscheme
if has("gui_running")
	colorscheme desert
else
	colorscheme Tomorrow-Night-Bright
	set mouse=a
endif

" Too long lines should be mildly highlighted
hi ColorColumn ctermbg=233 guibg=#444444

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

" jedi-vim
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#popup_on_dot = 0

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" syntastic
let g:syntastic_always_populate_loc_list = 1 "Make it populate loclist (like error) so :lnext/lprev work
let g:syntastic_python_pylint_post_args="--max-line-length=99"
let g:syntastic_python_checkers = ['flake8']

" unite.vim
" Cool flags: -quick-match -auto-preview
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Recursive file opening, asynchronous
nmap <leader>p :Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
" Show open buffers
nmap <leader>l :Unite -no-split -quick-match -buffer-name=buffers buffer<CR>
" Show outline
nmap <leader>o :Unite -auto-preview -no-split -buffer-name=outline -start-insert outline<CR>
" Launch file search
nmap <space>/ :Unite -no-split -auto-preview grep:.<CR>
" Yank history search
let g:unite_source_history_yank_enable = 1
nmap <leader>y :Unite -no-split -buffer-name=yank history/yank<cr>

if executable('ack')
	let g:unite_source_grep_command = 'ack'
	let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
	let g:unite_source_grep_recursive_opt = ''
endif

if executable('ag')
	" Use ag for recursive file search - will ignore stuff in .gitignore :-)
	let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
endif

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <silent><buffer><expr> <C-v> unite#do_action('right')
    imap <buffer> <C-j> <C-n>
    imap <buffer> <C-k> <C-p>
endfunction
