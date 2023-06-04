set scrolloff=8
set number
set relativenumber
set expandtab
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set termguicolors     " enable true colors support

call plug#begin(stdpath('data') . '/plugged')
"Fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"color scheme
Plug 'rebelot/kanagawa.nvim'

"treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

colorscheme kanagawa

let mapleader = " "
"n - mode
"nore - no recursion
"when leader-pv is pressed it will second part, :command mode Vex and enter
nnoremap <leader>pv :Vex<Cr>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>

