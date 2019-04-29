"set tabstop=4
"set softtabstop=4
"set shiftwidth=4
"set expandtab
"
set number
set showcmd
"
"filetype indent on

"set incsearch
"set hlsearch

" Lets you use yy to copy text to clipboard on MacOS
" https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing
set clipboard=unnamed

syntax enable
let g:solarized_termtrans = 1
colorscheme solarized
" togglebg#map("<F5>")

noremap <leader>y "*y
noremap <leader>yy "*Y

noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

