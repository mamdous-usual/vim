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

" Universal compile & run (Java, C, C++, Python)
function! CompileRun()
  write
  if &filetype == 'java'
    execute "!clear && javac % && java %:r"
  elseif &filetype == 'c'
    execute "!clear && gcc % -o %:r && ./%:r"
  elseif &filetype == 'cpp'
    execute "!clear && g++ % -o %:r && ./%:r"
  elseif &filetype == 'python'
    execute "!clear && python3 %"
  else
    echo "No compile rule for this filetype!"
  endif
endfunction

nnoremap <leader>r :call CompileRun()<CR>

" ===================== Plugin Setup =====================

call plug#begin('~/.vim/plugged')

" For autocomplete and installing LSP
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
