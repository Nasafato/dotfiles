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
set colorcolumn=80
set showmatch " shows matches when searching
set showcmd "show last command
set number " line numbers
set incsearch " incremental search as you type
set ignorecase
set smartcase
set hlsearch " highlight matches when you search
" Lets you use yy to copy text to clipboard on MacOS
" https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing
set clipboard=unnamed
set nowrap

filetype indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','
let maplocalleader = '-'

nnoremap g] :tjump<cr>

map Y y$
" noremap <leader>P :set paste<CR>:put *<CR>:set nopaste<CR>
inoremap jk <esc>
" inoremap kj <esc>
nnoremap <silent> <c-l> :<c-u>nohlsearch<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing and refreshing vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ev :split  ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.ts set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.styl  set filetype=stylus

augroup filetypes
    autocmd!
    autocmd FileType stylus setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType typescript.tsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
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

augroup javascript
    autocmd!
    autocmd FileType javascript.jsx noremap <leader>so f<space>xi<cr><esc>>>
    autocmd FileType typescript.tsx noremap <leader>so f<space>xi<cr><esc>>>
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

" FZF baby
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Best theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Status line
Plug 'vim-airline/vim-airline' 

" VSCode extensions for Vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Indent guides https://github.com/nathanaelkane/vim-indent-guides
" <leader>ig to toggle
Plug 'nathanaelkane/vim-indent-guides'

" Languages
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'iloginow/vim-stylus'
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" For vim stuff
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'christoomey/vim-tmux-navigator'


" For stuff like snake_case to CamelCase
Plug 'tpope/vim-abolish'

" Commenting
Plug 'tpope/vim-commentary'

" Improving netrw
Plug 'tpope/vim-vinegar'

" For communicating with Tmux
Plug 'benmills/vimux'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEMING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set termguicolors
let g:solarized_termcolors=256
let g:solarized_termtrans=1
highlight ColorColumn guibg=#23282C

if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme dracula

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_section_y=''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" `zo` to open fold
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker

augroup end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Development
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://stackoverflow.com/questions/33351179/how-to-rewrite-existing-vim-key-bindings
nmap <unique> <leader>_as <Plug>NetrwRefresh

" Fuzzy-finder commands.
" Searches through files in the workspace.
nnoremap <silent> <c-p> :Files<cr>
" Show the buffers and fuzzy-search through them.
nnoremap <silent> <leader>b :Buffers<cr>
" Searches through lines in the current buffer.
nnoremap <silent> <leader>/ :BLines<cr>
" Searches through vim commands.
nnoremap <silent> <leader>c :Commands<cr>
" ctrl-p && ctrl-n in fzf for prev and next search term
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': '30new' }
" Trying to emulate workspace search, but doesn't work all that well.
nnoremap <silent> <c-f> :Rg<cr>
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%')
            \         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \ <bang>0)


" Coc-nvim configuration.
source ~/.vim/coc-nvim.vimrc

function! RunMochaSingle(shouldInspect)
    call VimuxRunCommand("C-c")
    let testCmd = "clear; npm run mocha:single " . expand("%:p")
    if (a:shouldInspect)
        call VimuxRunCommand(testCmd . " -- --inspect-brk")
    else
        call VimuxRunCommand(testCmd)
    endif
endfunction

map <leader>tf :call RunMochaSingle(0)<cr>
map <leader>tfi :call RunMochaSingle(1)<cr>

function! RunLastCommand()
    call VimuxRunCommand("C-c")
    call VimuxRunCommand("!!")
    call VimuxSendKeys("Enter")
endfunction

map <leader>lc :call RunLastCommand()<cr>


" copy current filepath into clipboard
noremap <silent> <leader>yf :let @+ = expand("%")<cr>

noremap <silent> <leader>lf :!npm run lint:fix -- expand("%")<cr>

"""""""
" Git "
"""""""
noremap <silent> <leader>gb :Gblame<cr>

" Puts a Github link to the current line into your clipboard
nnoremap <leader>gl :.Gbrowse!<cr>
