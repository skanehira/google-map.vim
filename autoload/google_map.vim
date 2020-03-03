" google_map
" Author: skanehira
" License: MIT
"
let s:google_map_address_url = 'https://www.google.com/maps\?q=%s'
let s:google_map_routes_url = 'https://www.google.com/maps/dir/%s/%s'

function s:get_open_cmd() abort
  if has('mac')
    return 'open'
  elseif has('linux')
    return 'xdg-open'
  endif
endfunction

let g:google_map_open_cmd = s:get_open_cmd()

function s:echo_err(msg) abort
  echohl ErrorMsg
  echomsg a:msg
  echohl None
endfunction

function google_map#open(...) abort
  if !executable(g:google_map_open_cmd)
    call s:echo_err('not found open command: ' . g:google_map_open_cmd)
    return
  endif

  if a:0 > 1
    let cmd = printf('%s %s', g:google_map_open_cmd, printf(s:google_map_routes_url, a:1, a:2))
  else
    let cmd = printf('%s %s', g:google_map_open_cmd, printf(s:google_map_address_url, a:1))
  endif

  call job_start(cmd, {
        \ 'err_cb': function('s:err_cb'),
        \ })
endfunction

function s:err_cb(job, msg) abort
  call s:echo_err(a:msg)
endfunction
