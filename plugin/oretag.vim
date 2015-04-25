if exists('g:loaded_oretag')
  finish
endif
let g:loaded_oretag = 1

let s:save_cpo = &cpo
set cpo&vim

augroup Oretag
  autocmd!
  autocmd BufRead * call oretag#set_tag()
  autocmd BufWritePost * call oretag#generate_tag()
augroup END

""
" Generate tag file.
command! OretagGenerate call oretag#generate_tag()

let &cpo = s:save_cpo
unlet s:save_cpo

