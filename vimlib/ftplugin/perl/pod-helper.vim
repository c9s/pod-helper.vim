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

" 365 , unix
let g:pod_version_style = 'unix'

" Notice:
" if you like tranditional style , you can just press <C-a> to increment
" number, this is built-in feature.
fun! BumpVersionPerl()

  " current year and current day of 365 days
  let tstr = ''
  if g:pod_version_style == '365'

    let tstr = strftime('%y.%j.%H')

  " unix time stamp
  elseif g:pod_version_style == 'unix'
    let tstr = reltimestr( reltime() )
  endif

  cal setline('.', printf("our $VERSION = %s ;",tstr))
  redraw
  echo "version bumpped"
endf

com! BumpVersion  :cal BumpVersionPerl()
com! FillPodHere  :cal FillPod()

"nnoremap <C-c><C-b>  :BumpVersion<CR>
"nnoremap <C-c><C-p>  :FillPodHere<CR>
