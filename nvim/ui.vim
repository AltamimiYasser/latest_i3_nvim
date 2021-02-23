
" colorshcem
"colorscheme edge

let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1

" status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
