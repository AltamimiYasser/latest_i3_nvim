call plug#begin('~/.vim/plugged')
Plug 'mbbill/undotree'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
Plug 'ap/vim-css-color'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'szw/vim-maximizer'
Plug 'mattn/emmet-vim'
call plug#end()



" UNODTREE
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 2
endif
