let mapleader = " "

" 0 goes to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" space w save current file
nnoremap <leader>w :w<CR>
nnoremap <leader>q :wq<CR>

" shift p pste below the line
nnoremap P :pu<CR>


" toggle hlsearch with enter
nnoremap <CR> :noh<CR>

" don't jump fake lines
nnoremap j gj
nnoremap k gk

inoremap ii <Esc><Esc>
vnoremap ii <Esc><Esc>

nnoremap <leader>u :UndotreeToggle<CR>

" ctrl + arrow keys to move between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" space and combination for tab movement
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove
nnoremap <leader>t<leader> :tabnext<cr>

" te open a new tab in the current buffer's path
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" formating with F7
nnoremap <F7> gg=G
inoremap <F7> <Esc><Esc>gg=G'.i


" zz to put screen in the middle while in insert mode
inoremap zz <C-o>zz

" spacebar+f to fold and unfold
nnoremap <leader>f za

" space+n for nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>


" use leader plus hjkl to move between open windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" leader+vimrc open vimrc file from anyfile
nnoremap <leader>vimrc :tabnew<CR>:edit $MYVIMRC<CR>

nnoremap F :MaximizerToggle<CR>

" spell checking
nnoremap <C-space> z=
inoremap <C-space> <C-x>s
nnoremap <C-Bslash> zg

" dictionary
inoremap <F10> <C-X><C-K>

" delete all in a file
nnoremap <Leader>da gg0vG$d
