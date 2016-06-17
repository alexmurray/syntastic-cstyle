"============================================================================
"File:        cstyle.vim
"Description: CStyle C/C++ style checker plugin for Syntastic
"Maintainer:  Alex Murray <murray.alex@gmail.com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================
if exists('g:loaded_syntastic_c_cstyle_checker')
    finish
endif
let g:loaded_syntastic_c_cstyle_checker = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:syntastic_cstyle_config_file')
    let g:syntastic_cstyle_config_file = '.cstyle'
endif

function! SyntaxCheckers_c_cstyle_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'post_args': '--config ' . g:syntastic_cstyle_config_file })

    let errorformat =
        \     '%f:%l:%c: %m'

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style',
        \ 'returns': [0, 1] })

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'c',
    \ 'name': 'cstyle'})

let &cpo = s:save_cpo

unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
