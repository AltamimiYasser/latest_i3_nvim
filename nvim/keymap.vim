let mapleader = " "

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

" cn in command line will do tab new
ca tn tabnew


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
map <leader>vimrc :vsp new <CR>:edit $MYVIMRC<CR>

nnoremap F :MaximizerToggle<CR>



