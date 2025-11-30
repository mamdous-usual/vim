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

" Minimal UI enhancements
set noshowmode              " Don't show mode in command line (airline shows it)
set nocursorline            " Disable cursor line for minimal look
set fillchars=vert:│,fold:─,diff:─  " Clean window separators
set showtabline=2           " Always show tabline
set laststatus=2            " Always show statusline
set cmdheight=1             " Single line for command area
set shortmess+=c            " Don't show completion messages
set pumheight=10            " Limit popup menu height

" Enable true color support
if has("termguicolors")
  set termguicolors
endif

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

" Theme: Tokyo Night
Plug 'ghifarit53/tokyonight-vim'

" File explorer (optional but recommended for minimal workflow)
Plug 'preservim/nerdtree'

" Icons for a polished look (optional - requires nerd font)
Plug 'ryanoasis/vim-devicons'

" Better Java syntax highlighting
Plug 'uiiaoo/java-syntax.vim'

call plug#end()

" ===================== Theme =====================
set background=dark
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 0
colorscheme tokyonight

" ===================== Java Syntax Highlighting =====================
" Enable better Java highlighting
let g:java_highlight_functions = 1
let g:java_highlight_generics = 1
let g:java_highlight_debug = 1
let g:java_highlight_java_lang_ids = 1
let g:java_highlight_all = 1

" Custom Java class/type highlighting
augroup JavaHighlight
    autocmd!
    autocmd FileType java syntax match javaCustomClass "\<\([A-Z][a-zA-Z0-9]*\)\>"
    autocmd FileType java highlight link javaCustomClass Type
augroup END

" ===================== Airline Configuration =====================
let g:airline_theme='tokyonight'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0

" Minimal airline sections
let g:airline_section_z = airline#section#create(['%3p%%', 'linenr', 'maxlinenr', ' :%3v'])
let g:airline_skip_empty_sections = 1

" Disable unnecessary extensions for minimal look
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#enabled = 0

" Use minimal symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = '⚡'

" ===================== NERDTree Configuration (Optional) =====================
" Toggle NERDTree with Ctrl+n
nnoremap <C-n> :NERDTreeToggle<CR>

" Minimal NERDTree UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.git$', '\.DS_Store$', '__pycache__']
let NERDTreeWinSize = 30

" Close vim if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ===================== coc.nvim Configuration =====================
" Use <Enter> for completion
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Use <Tab> for completion and navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ===================== Prevent auto-commenting ====================
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=cro
autocmd BufEnter * setlocal formatoptions-=cro
augroup FormatOptions
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" ===================== Additional UI Polish =====================
" Smooth scrolling behavior
set scrolloff=8
set sidescrolloff=8

" Better search highlighting
highlight Search guibg=#3d59a1 guifg=#ffffff ctermbg=61 ctermfg=15
highlight IncSearch guibg=#bb9af7 guifg=#1a1b26 ctermbg=141 ctermfg=234

" Cleaner popup menu
highlight Pmenu guibg=#1f2335 guifg=#c0caf5 ctermbg=236 ctermfg=251
highlight PmenuSel guibg=#3d59a1 guifg=#ffffff ctermbg=61 ctermfg=15
highlight PmenuSbar guibg=#16161e ctermbg=234
highlight PmenuThumb guibg=#3d59a1 ctermbg=61

" Better split separators
highlight VertSplit guibg=NONE guifg=#1a1b26 ctermbg=NONE ctermfg=234

" Line number styling
highlight LineNr guifg=#3b4261 ctermfg=238
highlight CursorLineNr guifg=#7aa2f7 gui=bold ctermfg=111 cterm=bold
