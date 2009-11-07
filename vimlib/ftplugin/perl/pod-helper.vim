" pod helpers 
" =================================
"=VERSION 0.1

let s:td_pattern = '\(template [''"]\?\)\@<=[a-zA-Z0-9._/]\+'
let s:sub_pattern = '\(sub \)\@<=\w\+'
fun! PodTD(line)
  let tdname = matchstr( a:line , s:td_pattern )
  let tpl = [ "=head2 TEMPLATE " . tdname , "" , "" , "" , "=cut" , "" ]
  call append( line('.') - 1 , tpl )
  call cursor( line('.') - 4 , col('.') )
  startinsert
endf

fun! PodSub(line)
  let f = matchstr( a:line , s:sub_pattern )
  let tpl = [ "=head2 " . f , "" , "" , "" , "=cut" , "" ]
  call append( line('.') - 1 , tpl )
  call cursor( line('.') - 4 , col('.') )
endf

fun! FillPod()
  let l = getline('.')
  if  l =~ s:td_pattern
    cal PodTD(l)
  elseif l =~ s:sub_pattern
    cal PodSub(l)
  else

  endif
endf

nnoremap <silent> <C-c><C-p>  :call FillPod()<CR>
