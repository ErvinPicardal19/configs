function! BuildIncludeFlags(root) abort
    let l:includes = systemlist('find' . shellescape(a:root) . '-type d')
    return join(map(l:includes, {_, val -> '-I' . val}), ' ')
endfunction

let g:ale_c_cc_options = '-Wall -Wextra -I/usr/include -I/usr/local/include '
let g:ale_c_cc_options .= '-I' . BuildIncludeFlags(getcwd())
