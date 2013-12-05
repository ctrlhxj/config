call pathogen#infect()
set nocompatible

"display file name
set ls=2
set statusline=\[%t\]\ lin:%l\ col:%c%V\ %=\[%<%F%h%m%r%h%w\]\ %P

"set spell
set ruler
set history=1000
set tags=tags;/
set autoindent
set incsearch
set nowrapscan
syn match tab display "\t"
hi link tab Error
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text
\ autocmd BufWritePre <buffer>
\ :call <SID>StripTrailingWhitespaces()

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
set bs=2

"Vim Colors
set t_Co=256
"let g:solarized_termcolors=256
syntax enable
colorscheme ir_black
set hlsearch
highlight Search ctermbg=blue ctermfg=white cterm=NONE
highlight OverLength ctermbg=green ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @XmlSyntax syntax/xml.vim
if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif
syn region xhpCode start="<\(fbt\|\(ui\|x\|m\|fb\):[a-zA-Z0-9:\-]*\|a\|div\|span\|ul\)[^>/]*[^/]*>" keepend end="</\(fbt\|\(ui\|x\|m\|fb\):[a-zA-Z0-9:\-]*\|a\|div\|span\|ul\)>[ \n]*\()\|;\|,\)" contains=@XmlSyntax
syn cluster phpClConst add=xhpCode,xhpCodeSingleTag
syn cluster phpClInside add=xhpCode,xhpCodeSingleTag
syn cluster phpClFunction add=xhpCode,xhpCodeSingleTag
syn cluster phpClTop add=xhpCode,xhpCodeSingleTag
