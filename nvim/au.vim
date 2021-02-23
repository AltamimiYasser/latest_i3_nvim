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

augroup deleteTrailingWhiteSpace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

augroup rasiSyntaxHighlight
    autocmd!
    autocmd BufNewFile,BufRead /*.rasi setf css
augroup END


" Return to last edit position when opening files (You want this!)
augroup returnToLastEdited
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
