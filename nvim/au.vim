augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

augroup webdev
    autocmd!
    autocmd BufNewFile,BufRead  *.js,*.html,*.css,*.rb
                \  set tabstop=2
                \| set softtabstop=2
                \| set shiftwidth=2

augroup end
