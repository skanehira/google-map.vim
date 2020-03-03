" google_map
" Author: skanehira
" License: MIT

if exists('loaded_google_map') || has('win32')
  finish
endif
let g:loaded_google_map = 1

command! -narg=+ GoogleMap call google_map#open(<f-args>)
