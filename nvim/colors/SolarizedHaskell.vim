
hi clear
if exists("syntax_on")
  syntax reset
endif

set t_Co=16
set background=dark
runtime colors/solarized.vim
let g:colors_name = "SolarizedHaskell"

"exe "hi! haskellImportName"                 .s:fg_blue   .s:bg_none  .s:fmt_bold
hi! link haskellImportName              VarId
