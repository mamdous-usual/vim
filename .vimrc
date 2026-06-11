" ===================== Basic Settings =====================
syntax on
set clipboard=unnamedplus
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set splitright splitbelow
set updatetime=300
set background=dark
set hlsearch
set incsearch
set wildmenu
set encoding=utf-8
set mouse=a
set hidden
set noshowmode
set laststatus=2
set cmdheight=1
set shortmess+=c
set pumheight=10
set scrolloff=8
if has("termguicolors")
  set termguicolors
endif
let mapleader = " "

" ===================== Shortcuts =====================
nnoremap <leader>t :term<CR>
nnoremap <leader>vt :vert term<CR>
nnoremap <leader>ya :%y+<CR>
vnoremap <leader>y "+y
nnoremap <leader>w :w<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>e :NERDTreeToggle<CR>

" ===================== Comments =====================
" For Python / Bash / Vimscript style comments (#)
autocmd FileType python,sh,bash,vim nnoremap <buffer> <C-_> I# <Esc>
autocmd FileType python,sh,bash,vim vnoremap <buffer> <C-_> :normal I# <CR>

" For C / C++ / Java / JavaScript / Go style comments (//)
autocmd FileType c,cpp,java,javascript,go nnoremap <buffer> <C-_> I// <Esc>
autocmd FileType c,cpp,java,javascript,go vnoremap <buffer> <C-_> :normal I// <CR>


" ===================== Compile & Run =====================
function! CompileRun()
  write
  if &filetype == 'java'
    :terminal ++rows=15 ++close bash -c "javac % && java %:r; echo; read -p 'Press ENTER to close...'"
  elseif &filetype == 'c'
    :terminal ++rows=15 ++close bash -c "gcc % -o %:r && ./%:r; echo; read -p 'Press ENTER to close...'"
  elseif &filetype == 'cpp'
    :terminal ++rows=15 ++close bash -c "g++ % -o %:r && ./%:r; echo; read -p 'Press ENTER to close...'"
  elseif &filetype == 'python'
    :terminal ++rows=15 ++close bash -c "python3 %; echo; read -p 'Press ENTER to close...'"
  elseif &filetype == 'javascript'
    :terminal ++rows=15 ++close bash -c "node %; echo; read -p 'Press ENTER to close...'"
  else
    echo "No compile rule for this filetype!"
  endif
endfunction
nnoremap <leader>r :call CompileRun()<CR>

" ===================== Plugins =====================
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" ===================== Theme =====================
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_z = '%3p%% %l:%c'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = "\ue0b4"
let g:airline_left_alt_sep = "\ue0b5"
let g:airline_right_sep = "\ue0b6"
let g:airline_right_alt_sep = "\ue0b7"

" ===================== NERDTree =====================
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 0
let NERDTreeIgnore = ['\.git$', '\.class$']
let NERDTreeWinSize = 25
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ===================== coc.nvim =====================
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ===================== Misc =====================
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Prevent Vim from sending terminal initialization strings that leak as text
let &t_TI = ""
let &t_TE = ""
" Prevent Vim from querying terminal version (prevents random characters on startup)
set t_RV=
