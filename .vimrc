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
if has("win64") || has("win32")
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

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set fileformats=unix,mac,dos

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

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

" Highlight current line
set cursorline

set timeout
set timeoutlen=500

set completeopt=menuone,noselect

" Delete trailing white space on save, useful for some filetypes ;)
function! s:clean_extra_spaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call s:clean_extra_spaces()

autocmd FocusGained,BufEnter * checktime

" Return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" resize splits if window got resized
autocmd VimResized * tabdo wincmd =

" automatically create missing directories when saving files
augroup auto_create_dir
    autocmd!
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

autocmd FileType help nnoremap <buffer> <silent> q :quit<CR>


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

call plug#begin(s:plug_dir)
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'lambdalisue/fern.vim', { 'on': 'Fern' }
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'LunarWatcher/auto-pairs'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
silent! colorscheme onedark


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WhichKey
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"
let g:maplocalleader = ","
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

let g:which_key_map =  {}

let g:which_key_map.b = {
    \ 'name' : '+buffer' ,
    \ 'd' : ['bd'        , 'delete-buffer']   ,
    \ 'f' : ['bfirst'    , 'first-buffer']    ,
    \ 'l' : ['blast'     , 'last-buffer']     ,
    \ 'n' : ['bnext'     , 'next-buffer']     ,
    \ 'p' : ['bprevious' , 'previous-buffer'] ,
    \ '?' : ['buffers'   , 'buffers']         ,
    \ }

let g:which_key_map.c = {
    \ 'name' : '+coding',
    \ 'o' : ['TagbarToggle', 'Outline'],
    \ }

map <silent> <localleader><cr> :nohlsearch<cr>

" Remove the Windows ^M - when the encodings gets messed up
nnoremap <localleader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LSP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_log_verbose = 0
let g:lsp_format_sync_timeout = 1000

if executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable('lua-language-server')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'lua-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'lua-language-server']},
        \ 'allowlist': ['lua'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
endfunction

augroup lsp_install
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:which_key_map.l = {
    \ 'name' : '+lsp',
    \ 'd' : ['<plug>(lsp-definition)', 'definition'],
    \ 'f' : ['<plug>(lsp-document-format)', 'format'],
    \ 's' : ['<plug>(lsp-document-symbol-search)', 'document-symbol'],
    \ 'S' : ['<plug>(lsp-workspace-symbol-search)', 'workspace-symbol'],
    \ 'r' : ['<plug>(lsp-references)', 'references'],
    \ 'R' : ['<plug>(lsp-rename)', 'rename'],
    \ 'h' : ['<plug>(lsp-hover)', 'hover'],
    \ 'i' : ['<plug>(lsp-implementation)', 'implementation'],
    \ 't' : ['<plug>(lsp-type-definition)', 'type-definition'],
    \ 'g' : {
        \ 'name' : '+goto',
        \ 'n' : ['<plug>(lsp-next-diagnostic)', 'next-diagnostic'],
        \ 'p' : ['<plug>(lsp-previous-diagnostic)', 'previous-diagnostic'],
    \ },
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'down': '40%' }
let g:fzf_command_prefix = 'Fzf'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fern
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fern#drawer_keep = 1
let g:fern#default_hidden = 1
let g:fern#default_exclude = '.git$'

nnoremap <localleader>t :Fern . -drawer -reveal=% -toggle<CR>

function! s:fern_init() abort
    setlocal nonumber nobuflisted
    nnoremap <buffer> <silent> q :quit<CR>
endfunction

augroup fern_settings
    autocmd!
    autocmd FileType fern call s:fern_init()
augroup END

