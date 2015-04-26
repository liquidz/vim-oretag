""
" Ore no Ore niyoru Ore notameno ctag plugin.
"
"
" Requirement:
" * vim-yacd
"   https://github.com/liquidz/vim-yacd
"

let s:save_cpo = &cpo
set cpo&vim

""
" @var
" Set 1 to enable oretag at startup.
" Default value is 0.
if !exists('g:oretag#enable')
  let g:oretag#enable = 0
endif

""
" @var
" Directory path to save tag files.
" Default value is '~/.tags'.
if !exists('g:oretag#tag_dir')
  let g:oretag#tag_dir = '~/.tags'
endif

""
" @var
" ctags command.
" Default value is 'ctags'.
if !exists('g:oretag#ctags')
  let g:oretag#ctags = 'ctags'
endif

let s:V = vital#of('oretag')
let s:Http = s:V.import('Web.HTTP')
let s:Proc = s:V.import('Process')
let s:Filepath = s:V.import('System.Filepath')

function! s:get_repo_dir() abort
  let cwd = expand('%:p')
  return (cwd !=# '')
      \ ? yacd#get_root_dir(cwd)
      \ : ''
endfunction

""
" Return tag filename for specified repository directory and filetype.
function! oretag#get_tag_filename(repo_root_dir, filetype) abort
  let name = s:Http.encodeURIComponent(a:repo_root_dir)
      \ . '.' . a:filetype . '.tags'
  return s:Filepath.join(g:oretag#tag_dir, name)
endfunction

""
" Generate tag file.
function! oretag#generate_tag() abort
  if g:oretag#enable
    let repo_dir = s:get_repo_dir()
    if repo_dir !=# ''
      let tagfile = oretag#get_tag_filename(repo_dir, &filetype)
      let command = g:oretag#ctags
          \ . ' -f ' . tagfile
          \ . ' --languages=' . &filetype
          \ . ' ' . repo_dir
      call s:Proc.system(command)
    endif
  endif
endfunction

""
" Execute :setlocal tags=...
function! oretag#set_tag() abort
  if g:oretag#enable
    let repo_dir = s:get_repo_dir()
    let filename = oretag#get_tag_filename(repo_dir, &filetype)
    execute 'setlocal tags=' . filename
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
