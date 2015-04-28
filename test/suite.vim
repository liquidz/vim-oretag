let s:suite  = themis#suite('foo')
let s:assert = themis#helper('assert')

let s:V = vital#of('oretag')
let s:Filepath = s:V.import('System.Filepath')

function! s:suite.get_tag_filename_test() abort
  let g:oretag#tag_dir = 'foo'
  let expected = s:Filepath.join('foo', 'bar.baz.tags')
  let actual = oretag#get_tag_filename('bar', 'baz')
  call s:assert.equals(actual, expected)
endfunction
