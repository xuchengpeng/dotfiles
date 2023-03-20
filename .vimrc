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
set numberwidth=2

" Highlight current line
set cursorline

set timeout
set timeoutlen=500
set updatetime=200

set completeopt=menu,menuone,noselect

if has('win64') || has('win32')
  set shell=cmd
  set shellcmdflag=/C
  set shellquote= shellxquote=
endif

autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime

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
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinJoin', 'SplitjoinSplit'] }
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
Plug 'matze/vim-move'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)']  }
Plug 'nordtheme/vim', { 'as': 'nord.vim' }
Plug 'RRethy/vim-illuminate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermToggle', 'FloatermNew', 'FloatermKill', 'FloatermNext', 'FloatermPrev'] }
Plug 'Yggdroot/indentLine'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
  \ 'colorscheme': 'nord',
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

function! s:set_which_key_highlight() abort
  highlight default link WhichKey          Operator
  highlight default link WhichKeySeperator Keyword
  highlight default link WhichKeyGroup     Identifier
  highlight default link WhichKeyDesc      Function
  highlight default link WhichKeyFloating  Pmenu
endfunction

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

let g:leader_key_map =  {}
let g:localleader_key_map = {}

augroup which_key_install
  autocmd!
  autocmd ColorScheme * call s:set_which_key_highlight()
  autocmd User vim-which-key call which_key#register('<Space>', 'g:leader_key_map')
  autocmd User vim-which-key call which_key#register(',', 'g:localleader_key_map')
augroup END

let g:leader_key_map.b = {
  \ 'name' : '+Buffer',
  \ 'b': ['buffers', 'Buffers'],
  \ 'd': ['bdelete', 'Delete Buffer'],
  \ 'f': ['bfirst', 'First Buffer'],
  \ 'l': ['blast', 'Last Buffer'],
  \ 'n': ['bnext', 'Next Buffer'],
  \ 'p': ['bprevious', 'Previous Buffer'],
  \ }

nnoremap <silent> <localleader><cr> :nohlsearch<cr>

" Remove the Windows ^M - when the encodings gets messed up
nnoremap <silent> <localleader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
let g:localleader_key_map.m = 'Remove Windows ^M'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LSP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_log_verbose = 0
let g:lsp_format_sync_timeout = 1000

if executable('vim-language-server')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'vim-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vim-language-server', '--stdio']},
    \ 'allowlist': ['vim'],
    \ 'initialization_options': {
    \   'vimruntime': $VIMRUNTIME,
    \   'runtimepath': &rtp,
    \ }})
endif

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
    \ 'allowlist': ['sh'],
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

function! s:document_format() abort
  if &filetype ==# 'lua' && executable('stylua')
    silent !stylua %:p
  elseif &filetype ==# 'sh' && executable('shfmt')
    silent !shfmt -l -w %:p
  elseif &filetype ==# 'python' && executable('black')
    silent !black %:p
  elseif index(['html', 'json', 'jsonc', 'yaml', 'markdown'], &filetype) >= 0 && executable('prettier')
    silent! execute '!' . &shell . ' ' . &shellcmdflag . ' ' . 'prettier -w %:p'
  else
    execute 'LspDocumentFormat'
  endif
endfunction

command! DocumentFormat :call s:document_format()

let g:leader_key_map.l = {
  \ 'name' : '+Lsp',
  \ 'd': ['<plug>(lsp-definition)', 'Goto Definition'],
  \ 'f': ['DocumentFormat', 'Format'],
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vista
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'lua': 'vim_lsp',
  \ }

let g:leader_key_map.c = {
  \ 'name': '+Coding',
  \ 'e': ['FernExplore', 'Explore'],
  \ 'j': ['SplitjoinJoin', 'Join'],
  \ 's': ['SplitjoinSplit', 'Split'],
  \ 'o': ['Vista', 'Outline'],
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
  \ 'name': '+Fzf',
  \ 'b': ['FzfBuffers', 'Buffers'],
  \ 'f': ['FzfFiles', 'Find Files'],
  \ 'g': ['FzfRg', 'Grep'],
  \ 'r': ['FzfHistory', 'Recent Files'],
  \ 't': ['FzfBTags', 'Tags'],
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_map_keys = 0

autocmd FileType diff,git,fugitiveblame nnoremap <buffer> <silent> q :quit<CR>

command! GitBlame Git blame
command! GitDiff Git diff

let g:leader_key_map.g = {
  \ 'name': '+Git',
  \ 'b': ['GitBlame', 'Blame'],
  \ 'd': ['GitDiff', 'Diff'],
  \ 'P': ['GitGutterPreviewHunk', 'Preview Hunk'],
  \ 'p': ['GitGutterPrevHunk', 'Prev Hunk'],
  \ 'n': ['GitGutterNextHunk', 'Next Hunk'],
  \ 's': ['GitGutterStageHunk', 'Stage Hunk'],
  \ 'u': ['GitGutterUndoHunk', 'Undo Hunk'],
  \ }


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

nnoremap <silent> <localleader>g :Grepper<CR>
let g:localleader_key_map.g = 'Grep'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fern
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fern#drawer_keep = 1
let g:fern#default_hidden = 1
let g:fern#default_exclude = '.git$'

command! FernExplore Fern . -drawer -toggle

nnoremap <localleader>e :FernExplore<CR>
let g:localleader_key_map.e = 'Explore'

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

command! Btm FloatermNew btm
command! Gdu FloatermNew gdu
command! Lazygit FloatermNew lazygit
command! Glow FloatermNew glow
command! Python FloatermNew python

let g:leader_key_map.t = {
  \ 'name': '+Terminal',
  \ 'b': ['Btm', 'Bottom'],
  \ 'd': ['Gdu', 'Disk Usage'],
  \ 'l': ['Lazygit', 'Lazygit'],
  \ 'g': ['Glow', 'Glow'],
  \ 'p': ['Python', 'Python'],
  \ 'f' : {
    \ 'name': '+Floaterm',
    \ 'k': ['FloatermKill', 'Kill Terminal'],
    \ 't': ['FloatermNew', 'New Terminal'],
    \ 'n': ['FloatermNext', 'Next Terminal'],
    \ 'p': ['FloatermPrev', 'Prev Terminal'],
    \ },
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
let g:localleader_key_map.z = 'Zen Mode'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => illuminate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Illuminate_delay = 200
let g:Illuminate_ftblacklist = ['fern', 'qf', 'vista', 'vista_kind', 'vim-plug', 'startscreen']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_fileTypeExclude = ['startscreen']
let g:indentLine_bufTypeExclude = ['fern', 'qf', 'help', 'terminal', 'vista', 'vista_kind']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:leader_key_map.w = {
  \ 'name': '+Windows',
  \ 'w': ['FzfWindows', 'FzfWindows'],
  \ 'h': ['<C-W>h', 'Window Left'],
  \ 'j': ['<C-W>j', 'Window Blow'],
  \ 'k': ['<C-W>k', 'Window Up'],
  \ 'l': ['<C-W>l', 'Window Right'],
  \ 's': ['split', 'Split Window Blow'],
  \ 'v': ['vsplit', 'Split Window Right'],
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
  let padwidth = winwidth(0) / 2 - 13
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
    \ '> Find File              f',
    \ '> New File               n',
    \ '> Recent Files           r',
    \ '> Find Text              t',
    \ '> Configuration          c',
    \ '> Update Plugins         u',
    \ '> Quit VIM               q',
    \ ]
  for line in lists
    call append('$', leftpad . line)
  endfor

  " No modifications to this buffer
  setlocal nomodifiable nomodified

  " When we go to insert mode start a new buffer, and start insert
  nnoremap <buffer><silent> f :FzfFiles<CR>
  nnoremap <buffer><silent> n :enew<CR>
  nnoremap <buffer><silent> r :FzfHistory<CR>
  nnoremap <buffer><silent> t :FzfRg<CR>
  nnoremap <buffer><silent> c :e $MYVIMRC<CR>
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
silent! colorscheme nord

