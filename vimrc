" Install vim plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

"""" Misc
Plug 'bling/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'lfv89/vim-interestingwords'  " leader-k to mark words (nN to move around once over it, leader-K to unmark all)
Plug 'kien/rainbow_parentheses.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-unimpaired'
Plug 'benmills/vimux'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-speeddating'  | Plug 'vimwiki/vimwiki'

"""" Coding
Plug 'FooSoft/vim-argwrap'					"Wrap/unwrap things
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"""" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"""" Objects
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'

"""" Python
Plug 'alfredodeza/pytest.vim', {'for': 'python'}
Plug 'voithos/vim-python-matchit', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}

"""" Specific file types
Plug 'vim-scripts/csv.vim', {'for': 'csv'}
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}

"""" Unite
Plug 'Shougo/vimproc.vim', {'do': 'make'}  | Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neoyank.vim'

"""" Clojure/etc
Plug 'guns/vim-clojure-static', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'guns/vim-sexp', {'for': 'clojure'}

"""" Try out
" Plug 'jceb/vim-orgmode'
" Plug 'plasticboy/vim-markdown'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Download and install this into ~/.vim/colors :
" https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Bright.vim

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

""" Autocmd
if has("autocmd")
	filetype on
	filetype plugin indent on

	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	autocmd FileType python setlocal expandtab
	autocmd FileType python let &colorcolumn=join(range(80,100),",")
	autocmd FileType python let g:argwrap_tail_comma = 1	"Add trailing comma when wrapping
endif


nmap <silent><Leader>wb <Esc>:call HighlightBulletPoints()<CR>
function! HighlightBulletPoints()
	syn match TodoBullets /^[\*\-\+] \[ \]/
	highlight TodoBullets ctermfg=black ctermbg=red
	syn match HalfwayBullets /^[\*\-\+] \[[^X ]\] /
	highlight HalfwayBullets ctermfg=black ctermbg=yellow
	syn match DoneBullets /^[\*\-\+] \[X\] /
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
hi ColorColumn ctermbg=233 guibg=#444444

" It needs to be after filetype on for csv.vim
syntax on

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

" signify
let g:signify_vcs_list = ['git']

" jedi-vim
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" syntastic
let g:syntastic_always_populate_loc_list = 1 "Make it populate loclist (like error) so :lnext/lprev work
let g:syntastic_python_pylint_post_args="--max-line-length=99"
let g:syntastic_python_checkers = ['flake8']

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
nmap <space>/ :Unite -no-split -auto-preview grep:.<CR>
" Yank history search
let g:unite_source_history_yank_enable = 1
nmap <leader>y :Unite -no-split -quick-match -buffer-name=yanks history/yank<cr>

if executable('ag')
	" Use ag for recursive file search - will ignore stuff in .gitignore :-)
	" -- update: it does not ignore .tox at least :-(
	let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --hidden -g --ignore-dir=.tox/""'
endif

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <silent><buffer><expr> <C-v> unite#do_action('right')
    imap <buffer> <C-j> <C-n>
    imap <buffer> <C-k> <C-p>
endfunction

nnoremap <silent> <leader>w :ArgWrap<CR>

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring = 0

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


" Need to include ~/.vim/bundle/unite-outline/autoload/unite/sources/outline/vimwiki.vim
" Clone of defaul markdown.vim to bypass limitations sine outline-vimwiki won't work
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]


""" Auto-folding settings to display vimrc (reminder: zR undoes all folds)
" -vim:fdm=expr:fdl=0
" -vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='"

