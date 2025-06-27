" ===================== Basic settings =====================
syntax on
set clipboard+=unnamedplus
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set splitright splitbelow
set lazyredraw
set updatetime=300
set signcolumn=yes
set background=dark
set hlsearch
set t_Co=256
set wildmenu
set encoding=utf-8

" Enable true color support (for Gruvbox and airline)
if has("termguicolors")
  set termguicolors
endif

" Prevent auto-inserting comments on new lines
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Set leader key
let mapleader = " "

" ===================== Shortcuts =====================

" Terminal
nnoremap <leader>t :term<CR>
nnoremap <leader>vt :vert term<CR>

" Copy whole file to clipboard
nnoremap <leader>ya :%y+<CR>
vnoremap <leader>y "+y

" Java compile and run
nnoremap <leader>j :w<CR>:!clear && javac % && java %:r<CR>

" ===================== Plugin Setup =====================

call plug#begin('~/.vim/plugged')

" Java LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Airline statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Gruvbox theme
Plug 'morhetz/gruvbox'

call plug#end()

" ===================== Theme =====================

set background=dark
colorscheme gruvbox

" ===================== Airline Configuration =====================

let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1

" ===================== coc.nvim Configuration =====================

" Use <Tab> for completion and navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" ==================== End ==================== 
