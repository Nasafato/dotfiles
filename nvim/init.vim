set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if filereadable("~/.vimrc")
  source ~/.vimrc
endif

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
set termguicolors
syntax on

call plug#begin(stdpath('data') . '/plugged')
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'hashivim/vim-terraform'
Plug 'mhartington/formatter.nvim'
call plug#end()

let mapleader = ','
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :execute "vsplit" $MYVIMRC<cr>
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

lua require('config')
lua require('tmux')

lua << EOF
local map = vim.api.nvim_set_keymap
map('n', '<c-w>h', [[<cmd>lua require('tmux').move_left()<cr>]], {noremap=true}) 
map('n', '<c-w>j', [[<cmd>lua require('tmux').move_down()<cr>]], {noremap=true}) 
map('n', '<c-w>k', [[<cmd>lua require('tmux').move_up()<cr>]], {noremap=true}) 
map('n', '<c-w>l', [[<cmd>lua require('tmux').move_right()<cr>]], {noremap=true}) 
EOF

nnoremap <silent> <leader>ff :Format<cr>

