" Install vim plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Colorscheme install this into ~/.vim/colors :
" curl -fLo ~/.vim/colors --create-dirs https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Bright.vim

call plug#begin('~/.vim/plugged')

"""" Misc
Plug 'bling/vim-airline'
Plug 'lfv89/vim-interestingwords'  " leader-k to mark words (nN to move around once over it, leader-K to unmark all)
Plug 'kien/rainbow_parentheses.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating' | Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-obsession'
Plug 'elixir-lang/vim-elixir', {'for': 'elixir'}
Plug 'sanford1/unite-unicode'

"""" Basics
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'

"""" Coding
Plug 'FooSoft/vim-argwrap'					"Wrap/unwrap things
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'maralla/validator.vim'  "More sophisticated async linter
Plug 'xoliver/python-alternate.vim'

"""" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'  " More pleasant editing on commit message

"""" Objects
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'

"""" Python
Plug 'alfredodeza/pytest.vim', {'for': 'python'}
Plug 'voithos/vim-python-matchit', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'tmhedberg/SimpylFold'

"""" Specific file types
Plug 'vim-scripts/csv.vim', {'for': 'csv'}
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}

"""" Unite
Plug 'Shougo/vimproc.vim', {'do': 'make'}  | Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neoyank.vim'

"""" Try out
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'osyo-manga/vim-hopping'
Plug 'osyo-manga/vim-over'  "Replace overview
Plug 'metakirby5/codi.vim'  "Interactive scratchpad (python&co) - also as shell alias

call plug#end()


""" Internal
filetype plugin indent on

set t_Co=256
set background=dark
set clipboard=unnamed  "Enable copy-paste through tmux

set confirm  "Confirm when switching away from unsaved tab

set guioptions-=T  "remove toolbar

set history=1000
set wildmenu	"Activate showing autocomplete menu
set wildmode=longest,list,full	"Autocomplete as much as possible, do not go over options

map <Space> <Leader>
set showcmd

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

set backspace=indent,eol,start
"Backspace in normal mode -> jump to previous buffer
nnoremap <BS> :bprevious<CR>


" Search business
set ignorecase
set hlsearch
set incsearch
" Show matching brackets
set showmatch

set magic
syntax enable

"Tab business
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

""" Scroll, line numbers
set number	"Show line numbers
set relativenumber   "Show relative line numbers
set lazyredraw  "Lazy redraw of screen, improves speed of relative numbers
set scrolloff=10   "Offset when scrolling
set cursorline    "Show active line
"Show absolute line numbers in insert mode, relative otherwise
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

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

nnoremap <silent> <leader>aw :ArgWrap<CR>

""" Autocmd
if has("autocmd")
	filetype on
	filetype plugin indent on

	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	autocmd FileType python setlocal expandtab
	autocmd FileType python let &colorcolumn=join(range(80,99),",")

	autocmd FileType python let g:argwrap_tail_comma = 1	"Add trailing comma when wrapping

	au BufNewFile,BufFilePre,BufRead *.rpy set filetype=python
endif


nmap <silent><Leader>wb <Esc>:call HighlightBulletPoints()<CR>
function! HighlightBulletPoints()
	syn match TodoBullets /^[\*\-\+] \[ \]/
	highlight TodoBullets ctermfg=white ctermbg=1  " red
	syn match HalfwayBullets /^[\*\-\+] \[[^X ]\]/
	highlight HalfwayBullets ctermfg=white ctermbg=172  " orange
	syn match DoneBullets /^[\*\-\+] \[X\]/
	highlight DoneBullets ctermfg=green
endfunction

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

" Make the folder explorer look nicer
let g:netrw_liststyle=3

""" Colours
if has("gui_running")
	colorscheme desert
else
	colorscheme Tomorrow-Night-Bright
	set mouse=a
endif

" Too long lines should be mildly highlighted
hi ColorColumn guibg=#444444

" It needs to be after filetype on for csv.vim
syntax on

" Ctrl+L to clear search patterns
nnoremap <C-L> :nohlsearch<CR><C-L>

""" Files, folders
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

""" External plugins

" Airline
let g:airline#extensions#tabline#enabled = 0 "Do not show all open buffers on top bar (that way tabs show fine)
let g:airline_theme='dark'

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" signify
let g:signify_vcs_list = ['git']

" jedi-vim
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" validator
" let g:validator_auto_open_quickfix = 1
let g:validator_error_msg_format = "[%d/%d]"
let g:validator_python_flake8_args="--max-line-length=99"

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1  "Screw default mappings: Control+hjkl
nnoremap <silent> <C-W>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" pytest.vim
nmap <silent><Leader>f <Esc>:Pytest file<CR>
nmap <silent><Leader>c <Esc>:Pytest class<CR>
nmap <silent><Leader>m <Esc>:Pytest method<CR>


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
nmap <leader>/ :Unite -no-split -auto-preview grep:.<CR>
" Yank history search
let g:unite_source_history_yank_enable = 1
nmap <leader>y :Unite -no-split -quick-match -buffer-name=yanks history/yank<cr>

if executable('ag')
	" Use ag for recursive file search - will ignore stuff in .gitignore :-)
	let g:unite_source_rec_async_command = ['ag']
	let g:unite_source_rec_async_default_opts =
		\ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
		\  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
	let g:unite_source_rec_async_recursive_opt = ''
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts =
		\ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
		\  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
	let g:unite_source_grep_recursive_opt = ''
endif

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <silent><buffer><expr> <C-v> unite#do_action('right')
    imap <buffer> <C-j> <C-n>
    imap <buffer> <C-k> <C-p>
endfunction

"Use kj to leave insert mode
inoremap kj <ESC>

autocmd FileType python nnoremap <silent> <leader>. <Esc>:call OpenPythonAlternate()<CR>

let g:codi#width = 120

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring = 0


" Need to include ~/.vim/bundle/unite-outline/autoload/unite/sources/outline/vimwiki.vim
" Clone of defaul markdown.vim to bypass limitations sine outline-vimwiki won't work
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]


""" Enable navigation of quickfix issues in normal mode
nmap <silent> <C-N> :lne<CR>zv
nmap <silent> <C-P> :lp<CR>zv

" Vim-hopping
" Unsure about starter
nmap <silent> <leader>h :HoppingStart()<CR>
" Keymapping
let g:hopping#keymapping = {
\   "\<C-j>" : "<Over>(hopping-next)",
\   "\<C-k>" : "<Over>(hopping-prev)",
\   "\<C-u>" : "<Over>(scroll-u)",
\   "\<C-d>" : "<Over>(scroll-d)",
\}

""" Auto-folding settings to display vimrc (reminder: zR undoes all folds)
" -vim:fdm=expr:fdl=0
" -vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='"
