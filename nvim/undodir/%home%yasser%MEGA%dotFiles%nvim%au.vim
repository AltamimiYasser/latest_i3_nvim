Vim�UnDo� NQ{��ظ�F�v��J ���x����?                                     `2e�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             `2IM    �                   �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `2e�    �                 augroup END    �                  �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `2IV     �              �                augroup highlight_yank   
  autocmd!   E  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()   augroup END5��