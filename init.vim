" Lucas's Vimrc
set nocompatible
set number rnu
set mouse=a
set backspace=indent,eol,start

" My Vimrc
set colorcolumn=80
set clipboard=unnamed
set incsearch
set ignorecase
set smartcase
set hlsearch " highlight matches when you search
set hidden
set expandtab shiftwidth=2 smarttab
syntax on

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kevinoid/vim-jsonc'
call plug#end()

let base_init_vim = $BASE_INIT_VIM
let mapleader = ','
nnoremap <silent> <leader>sv :silent let f = system("zsh ~/bin/refresh-vim.sh")<bar>:redraw!<bar>:source $MYVIMRC<bar>:e<bar>:echo "Refreshed vim config"<cr>
nnoremap <leader>ev :execute "vsplit" base_init_vim<cr>
inoremap jk <esc>

nnoremap H ^
vnoremap H ^
onoremap H ^

nnoremap L $
vnoremap L $
onoremap L $

" colorscheme alan
colorscheme dracula
let g:airline_theme = "simple"

function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p:h')
  endif
  return getcwd()
endfunction!

let g:session_default_name = FindSessionDirectory()

nnoremap <silent> <c-p> :exe 'Files ' . g:session_default_name<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>/ :BLines<cr>
nnoremap <silent> <leader>c :Commands<cr>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <c-f> :Rg<cr>

noremap <silent> <leader>yf :let @+ = expand("%")<cr>
nnoremap <leader>gl :.GBrowse!<cr>
nnoremap <silent> <leader>gb :Git blame<cr>
