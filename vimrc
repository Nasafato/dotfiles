set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ruler
set cursorline

set showmatch " shows matches when searching
set showcmd "show last command
set number " line numbers

filetype indent on

set incsearch " incremental search as you type
set hlsearch " highlight matches when you search

" Lets you use yy to copy text to clipboard on MacOS
" https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing
set clipboard=unnamed

syntax enable
let g:solarized_termtrans = 1
colorscheme solarized
" togglebg#map("<F5>")

" I don't need these on Mac cause... setting clipboard=unnamed
" already takes care of it
" noremap <leader>y "*y
" noremap <leader>yy "*Y

noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif


