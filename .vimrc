" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax enable

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has('win64') || has('win32')
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase
set hlsearch
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Add a bit extra margin to the left
set foldcolumn=1

" Set regular expression engine automatically
set regexpengine=0

set mouse=a

set termguicolors

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Set extra options when running in GUI mode
if has('gui_running')
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Note: This should be set after `set termguicolors` or `set t_Co=256`.
" see :help termcap-cursor-shape
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
if &term =~ 'xterm' || &term == 'win32'
  let &t_SI = "\e[6 q"
  let &t_SR = "\e[4 q"
  let &t_EI = "\e[2 q"
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Use Unix as the standard file type
set fileformats=unix,mac,dos

" backup/swap/info/undo settings
set nobackup
set nowritebackup
set noswapfile
set noundofile
set backupdir=$HOME/.vim/files/backup/
set directory=$HOME/.vim/files/swap/
set undodir=$HOME/.vim/files/undo
set viewdir=$HOME/.vim/files/view
set viminfo='100,n$HOME/.vim/files/info/viminfo

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set linebreak
set textwidth=500

set autoindent 
set smartindent
set wrap

set noshowmode

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

" Always show the status line
set laststatus=2

" Show line number
set number
set numberwidth=2

" Highlight current line
set cursorline

set timeout
set timeoutlen=500
set updatetime=200

set completeopt=menu,menuone,noselect

" Return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" resize splits if window got resized
autocmd VimResized * tabdo wincmd =

" automatically create missing directories when saving files
augroup auto_create_dir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

autocmd FileType qf,help,man nnoremap <buffer> <silent> q :quit<CR>

autocmd FileType lua,vim setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2

" Search
if executable('rg')
  set grepprg=rg\ --vimgrep
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:plug_path = '~/.vim/autoload/plug.vim'
let s:plug_dir = '~/.vim/plugged'
if empty(glob(s:plug_path))
  silent !curl -fLo s:plug_path --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
silent! execute 'source ' . s:plug_path
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync
  \| endif

call plug#begin(s:plug_dir)
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)']  }
Plug 'RRethy/vim-illuminate'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'preservim/vim-indent-guides'
Plug 'preservim/nerdcommenter'
Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinJoin', 'SplitjoinSplit'] }
Plug 'matze/vim-move'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
silent! colorscheme catppuccin_mocha


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-startify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_custom_header = [
  \ '  ██╗   ██╗ ██╗ ███╗   ███╗ ',
  \ '  ██║   ██║ ██║ ████╗ ████║ ',
  \ '  ██║   ██║ ██║ ██╔████╔██║ ',
  \ '  ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ',
  \ '   ╚████╔╝  ██║ ██║ ╚═╝ ██║ ',
  \ '    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ',
  \ ]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WhichKey
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"
let g:maplocalleader = ","

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

let g:leader_key_map =  {}
let g:localleader_key_map = {}

augroup which_key_install
  autocmd!
  autocmd User vim-which-key call which_key#register('<Space>', 'g:leader_key_map')
  autocmd User vim-which-key call which_key#register(',', 'g:localleader_key_map')
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => auto complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:lsp_log_verbose = 0
let g:lsp_format_sync_timeout = 1000

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
endfunction

augroup lsp_install
  autocmd!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

if executable('vim-language-server')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'vim-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vim-language-server', '--stdio']},
    \ 'whitelist': ['vim'],
    \ 'initialization_options': {
    \   'vimruntime': $VIMRUNTIME,
    \   'runtimepath': &rtp,
    \ }})
endif

if executable('pyright')
  autocmd User lsp_setup cal lsp#register_server({
    \ 'name': 'pyright-langserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'pyright-langserver', '--stdio']},
    \ 'allowlist': ['python'],
    \ })
endif

if executable('bash-language-server')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'bash-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
    \ 'allowlist': ['sh', 'bash'],
    \ })
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'down': '40%' }
let g:fzf_command_prefix = 'Fzf'

if has('win64') || has('win32')
  set shell=cmd
  set shellcmdflag=/C
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-grepper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:grepper = {
  \ 'tools': ['rg', 'git'],
  \ 'rg': {
  \   'grepprg':    'rg --color never --smart-case --vimgrep',
  \   'grepformat': '%f:%l:%m',
  \   'escape':     '\+*^$()[]',
  \ }}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => illuminate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Illuminate_delay = 200
let g:Illuminate_ftblacklist = ['nerdtree', 'qf', 'startify', 'tagbar', 'vim-plug']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-indent-guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_default_mapping = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'qf', 'startify', 'tagbar']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autofocus = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:leader_key_map.b = {
  \ 'name' : '+Buffer',
  \ 'b': ['buffers', 'Buffers'],
  \ 'd': ['bdelete', 'Delete Buffer'],
  \ 'f': ['bfirst', 'First Buffer'],
  \ 'l': ['blast', 'Last Buffer'],
  \ 'n': ['bnext', 'Next Buffer'],
  \ 'p': ['bprevious', 'Previous Buffer'],
  \ }

let g:leader_key_map.c = {
  \ 'name': '+Coding',
  \ 'e': ['NERDTreeToggle', 'Explore'],
  \ 'j': ['SplitjoinJoin', 'Join'],
  \ 's': ['SplitjoinSplit', 'Split'],
  \ 't': ['TagbarToggle', 'Tags'],
  \ }

let g:leader_key_map.f = {
  \ 'name': '+Fzf',
  \ 'b': ['FzfBuffers', 'Buffers'],
  \ 'f': ['FzfFiles', 'Find Files'],
  \ 'g': ['FzfRg', 'Grep'],
  \ 'r': ['FzfHistory', 'Recent Files'],
  \ 't': ['FzfBTags', 'Tags'],
  \ 'w': ['FzfWindows', 'Windows'],
  \ }

let g:leader_key_map.l = {
  \ 'name' : '+Lsp',
  \ 'd': ['<plug>(lsp-definition)', 'Goto Definition'],
  \ 'f': ['<plug>(lsp-document-format)', 'Format'],
  \ 's': ['<plug>(lsp-document-symbol-search)', 'Document Symbol'],
  \ 'S': ['<plug>(lsp-workspace-symbol-search)', 'Workspace Symbol'],
  \ 'r': ['<plug>(lsp-references)', 'References'],
  \ 'R': ['<plug>(lsp-rename)', 'Rename'],
  \ 'h': ['<plug>(lsp-hover)', 'Hover'],
  \ 'i': ['<plug>(lsp-implementation)', 'Goto Implementation'],
  \ 't': ['<plug>(lsp-type-definition)', 'Goto Type Definition'],
  \ 'n': ['<plug>(lsp-next-diagnostic)', 'Next Diagnostic'],
  \ 'p': ['<plug>(lsp-previous-diagnostic)', 'Prev Diagnostic'],
  \ }

let g:leader_key_map.w = {
  \ 'name': '+Windows',
  \ 'h': ['<C-W>h', 'Window Left'],
  \ 'j': ['<C-W>j', 'Window Blow'],
  \ 'k': ['<C-W>k', 'Window Up'],
  \ 'l': ['<C-W>l', 'Window Right'],
  \ 's': ['split', 'Split Window Blow'],
  \ 'v': ['vsplit', 'Split Window Right'],
  \ }

let g:localleader_key_map.c = {
  \ 'name': '+Commenter',
  \ 'c': ['<plug>NERDCommenterComment', 'Comment'],
  \ 'i': ['<plug>NERDCommenterInvert', 'Invert'],
  \ 'm': ['<plug>NERDCommenterMinimal', 'Minimal'],
  \ 'n': ['<plug>NERDCommenterNested', 'Nested'],
  \ 's': ['<plug>NERDCommenterSexy', 'Sexy'],
  \ 't': ['<plug>NERDCommenterToggle', 'Toggle'],
  \ 'u': ['<plug>NERDCommenterUncomment', 'Uncomment'],
  \ }

nnoremap <silent> <localleader>g :Grepper<CR>
let g:localleader_key_map.g = 'Grep'

nnoremap <silent> <localleader>h :nohlsearch<cr>
let g:localleader_key_map.h = 'No Highlight Seach'
