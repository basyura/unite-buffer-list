
function! unite#sources#unite_buffer_list#define()
  return s:source
endfunction

let s:source = {
      \ 'name'           : 'unite/buffer/list',
      \ 'action_table'   : {},
      \ 'default_action' : {'common' : 'execute'},
      \ }

function! s:source.gather_candidates(args, context)

  redir => output
    silent ls!
  redir END

  let candidates = []
  for buf in split(output, '\n')
    let status = split(buf, '\s\+')
    if status[2] != '"*unite*'
      continue
    endif
    call add(candidates, {
      \ "word" : buf
      \ })
  endfor

  return candidates
endfunction

let s:source.action_table.execute = {'description' : 'open buffer'}
function! s:source.action_table.execute.func(candidate)
  let bufno = matchstr(split(a:candidate.word, '\s\+')[0], '\zs\d\+\ze')
  execute "e #" . bufno
endfunction

