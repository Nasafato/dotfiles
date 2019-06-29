" Adding fzf to your runtime path
" :echom '>^.^<'
":messages
"learning:begin
"learning:end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITOR CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ruler
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
" set cursorline
set scroll=20
set scrolloff=3
set colorcolumn=60,80,100
set showmatch " shows matches when searching
set showcmd "show last command
set number " line numbers
set incsearch " incremental search as you type
set hlsearch " highlight matches when you search
" Lets you use yy to copy text to clipboard on MacOS
" https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing
set clipboard=unnamed

filetype indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','
let maplocalleader = '-'


" noremap <leader>P :set paste<CR>:put *<CR>:set nopaste<CR>
inoremap jk <esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Operator-pending mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File navigation and text search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <c-f> :Rg<cr>
nnoremap <leader>o :Explore<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Capitalizing words
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In insert mode, capitalize the word you just typed out
inoremap <c-u> <esc>vbUea
" In normal mode, capitalize the current inner word
nnoremap <leader><c-u> viwU

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing and refreshing vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ev :split  ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quoting shit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
" surrounds visually selected text with quotes
" `< and `> let you select the start/end of the last visual selection
vnoremap <leader>" A"<esc>bi"<esc>`<lv`>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disabling the end and beginning of line movement keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap $ <nop>
vnoremap $ <nop>
nnoremap ^ <nop>
vnoremap ^ <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remapping end and beginning of the line movement keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap H ^
vnoremap H ^
onoremap H ^
nnoremap L $
vnoremap L $
onoremap L $

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remapping up/down paging keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev @@ alanjgou@gmail.com

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CURSOR
" https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $TERM_PROGRAM =~ "iTerm"
    " insert mode = vertical bar
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    " replace mode = underline
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    " normal mode = block
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    " Vertical bar in insert mode
    " let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " Block in normal mode
    " let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[0 q"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx

augroup filetypes
    autocmd!
    autocmd FileType javascript.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType css set tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType javascript.jsx nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python iabbrev <buffer> iff if:<left>
augroup END

augroup markdown
    autocmd!
    onoremap ih :<c-u>execute "normal! ?^==\\+$:nohlsearch\rkvg_"<cr>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
" Vim-plug https://github.com/junegunn/vim-plug
" By the creator of fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
" Plug 'chriskempson/base18-vim'
" Plug 'w0rp/ale'
Plug 'tpope/vim-vinegar'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-airline/vim-airline' 
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LINTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ale_linters = {'javascript': ['eslint']}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEMING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set termguicolors
let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
" colorscheme solarized8
" colorscheme desert
colorscheme dracula
" togglebg#map("<F5>")
highlight ColorColumn guibg=#23282C

if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_section_y=''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC INTELLISENSE
" Remap keys for gotos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc.nvim settings ---------------------- {{{
" nnoremap <silent> gd <Plug>(coc-definition)
" nnoremap <silent> gy <Plug>(coc-type-definition)
" nnoremap <silent> gi <Plug>(coc-implementation)
" nnoremap <silent> gr <Plug>(coc-references)
" " === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

set cmdheight=2
set updatetime=300
set signcolumn=yes

nnoremap <silent> <space>f :<c-u>CocAction('format')<cr>
nnoremap <silent> <space>d :<c-u>CocList diagnostics<cr>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker

augroup end
" }}}

