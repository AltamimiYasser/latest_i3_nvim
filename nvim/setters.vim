filetype on
filetype indent on

" not grouped
set shell=/bin/zsh
set mouse=nv
set clipboard=unnamedplus
set number
set relativenumber
set lazyredraw
set hidden
set signcolumn=yes
set autochdir
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set cmdheight=2
set whichwrap+=<,>,h,l
set mat=2


" spell check
set spell
setlocal spell spelllang=en_us
set spelloptions=camel
set thesaurus+=
set dictionary+=/user/share/dict/words
set complete+=k
" acknowledgment

" ui
set termguicolors
set spellcapcheck=""
set foldcolumn=1
set noerrorbells
set showmatch
set splitright
set splitbelow
set guicursor=
set scrolloff=8 "start scrolling 8 lines before the end or start


" tab and indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent "
set expandtab
set smartindent
set fileformat=unix
set backspace=eol,start,indent


" wrap
set wrap
set textwidth=0 " wrap till the end of screen
set wrapmargin=0
set colorcolumn=80
set breakindent
set linebreak
set showbreak=>>


" search
set smartcase
set ignorecase


" undo
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile

" lua syntax highlight
let g:vimsyn_embed= 'lPr'
