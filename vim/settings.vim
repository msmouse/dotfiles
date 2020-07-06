let vimsettings = '~/.vim/settings'
let uname = system("uname -s")

for fpath in split(globpath(vimsettings, '*.vim'), '\n')

  if (fpath == expand(vimsettings) . "/yadr-keymap-mac.vim") && uname[:4] ==? "linux"
    continue " skip mac mappings for linux
  endif

  if (fpath == expand(vimsettings) . "/yadr-keymap-linux.vim") && uname[:4] !=? "linux"
    continue " skip linux mappings for mac
  endif

  exe 'source' fpath
endfor

" my settings

autocmd FileType vo_base set foldminlines=0
autocmd FileType vo_base set sw=2
autocmd FileType vo_base set ts=2

autocmd BufWinEnter *.otl loadview
autocmd BufWinLeave *.otl mkview

function! ReverseTaskStatus()
 let line = getline(".")
 if( match( line, " --DONE--$" ) < 0 )
   let line = substitute( line, "$", " --DONE--", "" )
 else
   let line = substitute( line, " --DONE--$", "", "" )
 endif
 call setline( ".", line )
endfunction
autocmd FileType vo_base nmap <silent> <SPACE> :call ReverseTaskStatus()<CR>
