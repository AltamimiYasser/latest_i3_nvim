Vim�UnDo� ���lט���Wz��Q��7�j��LP�Xg�?|   �   
" UNODTREE   �                           `1��    _�                             ����                                                                                                                                                                                                                                                                                                                                      B                  `1��     �      C   �   A   filetype on   filetype plugin on "   filetype indent on   ! " lets test this until it breaks           " not grouped   set noerrorbells   set fileformat=unix   set encoding=utf-8 "   set nocompatible   set shell=/bin/fish   *set path+=** " search down into subfolders   set wildmenu "   set mouse=nv   set clipboard=unnamedplus   
set number   set relativenumber   set showcmd "   set cursorline   set lazyredraw   set showmatch   set verbose   set splitright   set splitbelow   set termwinsize=10x0   set guicursor=   
set hidden   @set scrolloff=8 "start scrolling 8 lines before the end or start   set signcolumn=yes   set nofsync "           " tab and indent   set tabstop=4   set softtabstop=4   set shiftwidth=4   set autoindent "   set expandtab   set smartindent           " wrap   set wrap   -set textwidth=0 " wrpe till the end of screen   set wrapmargin=0   set colorcolumn=80   set breakindent   set linebreak   set showbreak=>>           " search   set smartcase   set ignorecase   set incsearch "   set hlsearch "           " undo   set noswapfile   set nobackup   set undodir=~/.vim/undodir   set undofile    �          �      syntax enable "5�_�                    \        ����                                                                                                                                                                                                                                                                                                                            \           �                   `1�	     �   \   �   �   <   let mapleader = " "       " shift p pste below the line   nnoremap P :pu<CR>       " go back to last buffer   nnoremap <C-b> :CtrlPBuffer<CR>       " toggle hlsearch with enter   nnoremap <CR> :noh<CR>       " don't jump fake lines   nnoremap j gj   nnoremap k gk       inoremap ii <Esc><Esc>   vnoremap ii <Esc><Esc>       &nnoremap <leader>u :UndotreeToggle<CR>       (" ctrl + arrow keys to move between tabs   "nnoremap <C-Left> :tabprevious<CR>   nnoremap <C-Right> :tabnext<CR>       $" cn in command line will do tab new   ca tn tabnew           " formating with F7   nnoremap <F7> gg=G   inoremap <F7> <Esc><Esc>gg=G'.i           5" zz to put screen in the middle while in insert mode   inoremap zz <C-o>zz       " save with :Sw as sudo   .command! -nargs=0 Sw w !sudo tee % > /dev/null       " use Q for q!   nnoremap Q :q!       " spacebar+f to fold and unfold   nnoremap <leader>f za       " space+n for nerdtree   &nnoremap <leader>n :NERDTreeToggle<CR>           3" use leader plus hjkl to move between open windows    nnoremap <leader>h :wincmd h<CR>    nnoremap <leader>j :wincmd j<CR>    nnoremap <leader>k :wincmd k<CR>    nnoremap <leader>l :wincmd l<CR>       +" leader+vimrc open vimrc file from anyfile   1map <leader>vimrc :vsp new <CR>:edit $MYVIMRC<CR>       nnoremap F :MaximizerToggle<CR>    �   [   ]   �       5�_�                     �        ����                                                                                                                                                                                                                                                                                                                            �           �                   `1��    �   �              %if !exists('g:undotree_WindowLayout')   #    let g:undotree_WindowLayout = 2   endif�   �   �   �      
" UNODTREE5��