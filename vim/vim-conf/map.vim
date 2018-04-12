" Map keys in this part

" <ESC> in insert and visual mode {{{
inoremap jk <esc>
vnoremap ui <esc>
" }}}

" write buffer and exit {{{
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
" }}}

" command line with <..> {{{
nnoremap .. :
" }}}

" Size of current view {{{
" Increase view's height by 1
nnoremap <silent><leader>vk :resize +1<cr>
" Decrease view's height by 1
nnoremap <silent><leader>vj :resize -1<cr>
" Increase view's width by 1
nnoremap <silent><leader>vl :vertical resize +1<cr>
" Decrease view's width by 1
nnoremap <silent><leader>vh :vertical resize -1<cr>
" }}}

" Change focus on view {{{
" change to below view
nnoremap <silent><leader>cj :wincmd j<cr>
" change to upside view
nnoremap <silent><leader>ck :wincmd k<cr>
" change to left view
nnoremap <silent><leader>ch :wincmd h<cr>
" change to right view
nnoremap <silent><leader>cl :wincmd l<cr>
" change to top view
nnoremap <silent><leader>ct :wincmd t<cr>
" change to bottom view
nnoremap <silent><leader>cb :wincmd b<cr>
" }}}

" change position of view in window {{{
" Move to below position
nnoremap <silent><leader>ej :wincmd J<cr>
" Move to upside position
nnoremap <silent><leader>ek :wincmd K<cr>
" Move to left position
nnoremap <silent><leader>eh :wincmd H<cr>
" Move to right position
nnoremap <silent><leader>el :wincmd L<cr>
" Rotate view downward or rightward
nnoremap <silent><leader>er :wincmd r<cr>
" Rotate view upward or leftward
nnoremap <silent><leader>eR :wincmd R<cr>
" Move to last
nnoremap <silent><leader>ex :wincmd x<cr>
" close other views
nnoremap <silent><leader>eo :only<cr>
" }}}

" Work in Buffer {{{
" Next buffer, if it exist
nnoremap <silent><leader>bn :bn<cr>
" Previos buffer, if it exist.
nnoremap <silent><leader>bp :bp<cr>
" }}}

" Full screen toggle in linux {{{
if has('gui_running') && g:islinux
    nnoremap <silent><F11>
\   :call system("wmctrl -ir ".v:windowid." -b toggle,fullscreen")<cr>
endif
" }}}

" Copy, cut, paste {{{
vnoremap <c-c> "+y
nnoremap <c-v> "+p
vnoremap <c-x> "+c
" }}}

" ReadLine in insert mode {{{
inoremap <silent><c-f> <right>
inoremap <silent><c-b> <left>
inoremap <silent><c-n> <down>
inoremap <silent><c-p> <up>
inoremap <silent><c-d> <backspace>
inoremap <silent><a-f> <esc><right>wi
inoremap <silent><a-b> <esc><right>bi
"}}}