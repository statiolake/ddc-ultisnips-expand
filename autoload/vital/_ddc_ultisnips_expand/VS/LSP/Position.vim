" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not modify the code nor insert new lines before '" ___vital___'
function! s:_SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
endfunction
execute join(['function! vital#_ddc_ultisnips_expand#VS#LSP#Position#import() abort', printf("return map({'cursor': '', 'vim_to_lsp': '', 'lsp_to_vim': ''}, \"vital#_ddc_ultisnips_expand#function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
delfunction s:_SID
" ___vital___
"
" cursor
"
function! s:cursor() abort
  return s:vim_to_lsp('%', getpos('.')[1 : 3])
endfunction

"
" vim_to_lsp
"
function! s:vim_to_lsp(expr, pos) abort
  let l:line = s:_get_buffer_line(a:expr, a:pos[0])
  if l:line is v:null
    return {
    \   'line': a:pos[0] - 1,
    \   'character': a:pos[1] - 1
    \ }
  endif

  return {
  \   'line': a:pos[0] - 1,
  \   'character': strchars(strpart(l:line, 0, a:pos[1] - 1))
  \ }
endfunction

"
" lsp_to_vim
"
function! s:lsp_to_vim(expr, position) abort
  let l:line = s:_get_buffer_line(a:expr, a:position.line + 1)
  if l:line is v:null
    return [a:position.line + 1, a:position.character + 1]
  endif
  return [a:position.line + 1, byteidx(l:line, a:position.character) + 1]
endfunction

"
" _get_buffer_line
"
function! s:_get_buffer_line(expr, lnum) abort
  try
    let l:expr = bufnr(a:expr)
  catch /.*/
    let l:expr = a:expr
  endtry
  if bufloaded(l:expr)
    return get(getbufline(l:expr, a:lnum), 0, v:null)
  elseif filereadable(a:expr)
    return get(readfile(a:expr, '', a:lnum), 0, v:null)
  endif
  return v:null
endfunction
