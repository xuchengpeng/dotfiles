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

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup
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

set completeopt=menu,menuone,noselect

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

autocmd FileType qf,help,man nnoremap <buffer> <silent> q :quit<CR>

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
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }
Plug 'LunarWatcher/auto-pairs'
Plug 'lambdalisue/fern.vim', { 'on': 'Fern' }
Plug 'RRethy/vim-illuminate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermToggle', 'FloatermNew', 'FloatermKill', 'FloatermNext', 'FloatermPrev'] }
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

let g:leader_key_map =  {}
let g:localleader_key_map = {}

augroup which_key_install
    autocmd!
    autocmd User vim-which-key call which_key#register('<Space>', 'g:leader_key_map')
    autocmd User vim-which-key call which_key#register(',', 'g:localleader_key_map')
augroup END

let g:leader_key_map.b = {
    \ 'name' : '+buffer',
    \ 'b': ['buffers', 'buffers'],
    \ 'd': ['bd', 'delete-buffer'],
    \ 'f': ['bfirst', 'first-buffer'],
    \ 'l': ['blast', 'last-buffer'],
    \ 'n': ['bnext', 'next-buffer'],
    \ 'p': ['bprevious', 'previous-buffer'],
    \ }

nnoremap <silent> <localleader><cr> :nohlsearch<cr>

" Remove the Windows ^M - when the encodings gets messed up
nnoremap <silent> <localleader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
let g:localleader_key_map.m = 'remove Windows ^M'


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

let g:leader_key_map.l = {
    \ 'name' : '+lsp',
    \ 'd': ['<plug>(lsp-definition)', 'definition'],
    \ 'f': ['<plug>(lsp-document-format)', 'format'],
    \ 's': ['<plug>(lsp-document-symbol-search)', 'document-symbol'],
    \ 'S': ['<plug>(lsp-workspace-symbol-search)', 'workspace-symbol'],
    \ 'r': ['<plug>(lsp-references)', 'references'],
    \ 'R': ['<plug>(lsp-rename)', 'rename'],
    \ 'h': ['<plug>(lsp-hover)', 'hover'],
    \ 'i': ['<plug>(lsp-implementation)', 'implementation'],
    \ 't': ['<plug>(lsp-type-definition)', 'type-definition'],
    \ 'n': ['<plug>(lsp-next-diagnostic)', 'next-diagnostic'],
    \ 'p': ['<plug>(lsp-previous-diagnostic)', 'previous-diagnostic'],
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vista
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vista_executive_for = {
    \ 'cpp': 'vim_lsp',
    \ 'lua': 'vim_lsp',
    \ }

let g:leader_key_map.c = {
    \ 'name': '+coding',
    \ 't': ['Vista', 'tags'],
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'down': '40%' }
let g:fzf_command_prefix = 'Fzf'

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'],
    \ }

let g:leader_key_map.f = {
    \ 'name': '+fzf',
    \ 'b': ['FzfBuffers', 'buffers'],
    \ 'f': ['FzfFiles', 'find'],
    \ 'g': ['FzfRg', 'grep'],
    \ 'r': ['FzfHistory', 'recent files'],
    \ 't': ['FzfBTags', 'tags'],
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fern
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fern#drawer_keep = 1
let g:fern#default_hidden = 1
let g:fern#default_exclude = '.git$'

nnoremap <localleader>e :Fern . -drawer -toggle<CR>
let g:localleader_key_map.e = 'explore'

function! s:fern_init() abort
    setlocal nonumber nobuflisted
    nnoremap <buffer> <silent> q :quit<CR>
endfunction

augroup fern_settings
    autocmd!
    autocmd FileType fern call s:fern_init()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => floaterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

hi Floaterm guibg=black
let g:floaterm_keymap_toggle = '<F12>'

let g:leader_key_map.t = {
    \ 'name': '+terminal',
    \ 'k': ['FloatermKill', 'kill'],
    \ 't': ['FloatermNew', 'new'],
    \ 'n': ['FloatermNext', 'next'],
    \ 'p': ['FloatermPrev', 'prev'],
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => zen mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width = '120'
let g:goyo_height = '85%'
let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_conceal_guifg = 'Gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

nnoremap <silent> <localleader>z :Goyo<CR>
let g:localleader_key_map.z = 'zen mode'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => illuminate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Illuminate_delay = 200
let g:Illuminate_ftblacklist = ['fern', 'vista', 'vista_kind', 'vim-plug']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:leader_key_map.w = {
    \ 'name': '+windows',
    \ 'w': ['FzfWindows', 'FzfWindows'],
    \ 'h': ['<C-W>h', 'window-left'],
    \ 'j': ['<C-W>j', 'window-blow'],
    \ 'k': ['<C-W>k', 'window-up'],
    \ 'l': ['<C-W>l', 'window-right'],
    \ 's': ['split', 'split-window-blow'],
    \ 'v': ['vsplit', 'split-window-right'],
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => startup screen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:draw_startscreen() abort
    " Start a new buffer...
    enew

    " ...and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber
        \ statusline=%y
        \ filetype=startscreen

    " Now we can just write to the buffer whatever you want.
    let padwidth = winwidth(0) / 2 - 30
    if padwidth < 3
        let padwidth = 3
    endif
    let leftpad = repeat(' ', padwidth)
    let header = [
        \ '                          ',
        \ '  ██╗   ██╗██╗███╗   ███╗ ',
        \ '  ██║   ██║██║████╗ ████║ ',
        \ '  ██║   ██║██║██╔████╔██║ ',
        \ '  ╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        \ '   ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        \ '    ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        \ '                          ',
        \ ]
    for line in header
        call append('$', leftpad . line)
    endfor
    let lists = [
        \ '> New file               e',
        \ '> Find files             f',
        \ '> Grep word              g',
        \ '> Recent files           r',
        \ '> Settings               s',
        \ '> Update plugins         u',
        \ '> Quit VIM               q',
        \ ]
    for line in lists
        call append('$', leftpad . line)
    endfor

    " No modifications to this buffer
    setlocal nomodifiable nomodified

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> f :FzfFiles<CR>
    nnoremap <buffer><silent> g :FzfRg<CR>
    nnoremap <buffer><silent> r :FzfHistory<CR>
    nnoremap <buffer><silent> s :e $MYVIMRC<CR>
    nnoremap <buffer><silent> u :PlugUpdate<CR>
    nnoremap <buffer><silent> q :quit<CR>
endfunction

function! s:redraw_startscreen() abort
    if &filetype ==# 'startscreen'
        call s:draw_startscreen()
    endif
endfunction

function! s:startscreen() abort
    " Don't run if:
    " - there are commandline arguments;
    " - the buffer isn't empty (e.g. cmd | vi -);
    " - we're not invoked as vim or gvim;
    " - we're starting in insert mode.
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    call s:draw_startscreen()
endfunction

augroup startscreen
    autocmd!
    autocmd VimEnter * call s:startscreen()
    autocmd VimResized * call s:redraw_startscreen()
augroup END

command! StartScreen :call s:draw_startscreen()
