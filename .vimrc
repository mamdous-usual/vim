" ===================== Basic Settings =====================
syntax on
set clipboard=unnamedplus
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set splitright splitbelow
set lazyredraw
set updatetime=300
set signcolumn=no
set background=dark
set hlsearch
set incsearch
set t_Co=256
set wildmenu
set encoding=utf-8
set mouse=a
set hidden

" Minimal UI
set noshowmode
set nocursorline
set fillchars=vert:\ ,fold:\ ,diff:\ 
set showtabline=0
set laststatus=2
set cmdheight=1
set shortmess+=c
set pumheight=10

" True color support
if has("termguicolors")
  set termguicolors
endif

" Leader key
let mapleader = " "

" ===================== Shortcuts =====================
" Terminal 
nnoremap <leader>t :term<CR>
nnoremap <leader>vt :vert term<CR>

" Copy operations
nnoremap <leader>ya :%y+<CR>
vnoremap <leader>y "+y

" Quick save
nnoremap <leader>w :w<CR>

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" ===================== Compile & Run =====================
function! CompileRun()
  write
  let l:ext = expand('%:e')
  
  if l:ext == 'java'
    let l:classname = expand('%:t:r')
    execute "!clear && javac % && java " . l:classname
  elseif l:ext == 'cpp'
    let l:output = expand('%:t:r')
    execute "!clear && g++ % -o " . l:output . " && ./" . l:output
  elseif l:ext == 'c'
    let l:output = expand('%:t:r')
    execute "!clear && gcc % -o " . l:output . " && ./" . l:output
  elseif l:ext == 'py'
    execute "!clear && python3 %"
  endif
endfunction

nnoremap <leader>r :call CompileRun()<CR>

" ===================== Plugin Setup =====================
call plug#begin('~/.vim/plugged')

" Autocomplete and LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Statusline
Plug 'vim-airline/vim-airline'

" Theme: OneDark
Plug 'joshdick/onedark.vim'

" File explorer
Plug 'preservim/nerdtree'

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ===================== Theme =====================
colorscheme onedark

" ===================== Java Syntax Highlighting =====================
let g:java_highlight_functions = 1
let g:java_highlight_generics = 1
let g:java_highlight_all = 1

" ===================== Airline Configuration =====================
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = '%3p%% %l:%c'
let g:airline_skip_empty_sections = 1

" Rounded separators
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = "\ue0b4"
let g:airline_left_alt_sep = "\ue0b5"
let g:airline_right_sep = "\ue0b6"
let g:airline_right_alt_sep = "\ue0b7"

" ===================== NERDTree Configuration =====================
nnoremap <C-n> :NERDTreeToggle<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 0
let NERDTreeIgnore = ['\.git$', '\.class$']
let NERDTreeWinSize = 25

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ===================== coc.nvim Configuration =====================
" Use <Enter> for completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Use <Tab> intelligently for coc completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ===================== Prevent Auto-commenting =====================
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ===================== UI Polish =====================
set scrolloff=8
set sidescrolloff=8

