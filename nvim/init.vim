
" Plugins
call plug#begin('~/.config/nvim/plugged')
"Plug 'altercation/vim-colors-solarized'
"Plug 'neovimhaskell/haskell-vim'

"Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'ntpeters/vim-better-whitespace'


Plug 'lnl7/vim-nix'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'ngmy/vim-rubocop'

"Plug 'elzr/vim-json'
"Plug 'floobits/floobits-neovim'
"Plug 'l04m33/vim-skuld'
call plug#end()

" Leader
let mapleader = ","
let maplocalleader = "\\"
" nmap , <space>

" Comments
let g:NERDSpaceDelims = 1
map <leader>cc ,c<space>
map <space>cc ,c<space>

" Tabular
nmap <space>t :Tabularize /
vmap <space>t :Tabularize /

" Easymotion
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
nmap <space>j <Plug>(easymotion-j)
nmap <space>k <Plug>(easymotion-k)
nmap <space>l <Plug>(easymotion-lineforward)
nmap <space>h <Plug>(easymotion-linebackward)

" RuboCop
" let g:vimrubocop_config = '~/Projects/1bios/omni/lib-core/bin'

" Folding
set nofoldenable

" Fix slow regex in ruby files
set re=1
" General Options
set ea
set eadirection=hor
set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set novisualbell
set nocursorline
set ttyfast
set ruler
set relativenumber
set laststatus=2
set showtabline=0
set history=1000
set undofile
set undoreload=10000
set cpoptions+=J
set shell=/run/current-system/sw/bin/bash
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set encoding=utf-8
set fillchars=stl:\ ,diff:⣿
set ttimeout
set notimeout
set nottimeout
set autowrite
set shiftround
set autoread
set title
set linebreak
set dictionary=/usr/share/dict/words
set backspace=indent,eol,start
set listchars=tab:▸\ ,eol:¬,trail:·
"set list
set display=lastline

" Toggle spell checking
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>z z=1<CR><CR>

" Toggle show list chars
nmap <leader>l :set list!<CR>

" Tabs, spaces, wrapping
set expandtab
set wrap
"set nowrap
set wrapmargin=1
set textwidth=80
set formatoptions=qrn1
set colorcolumn=0 "+=1

" Backups
set undodir=~/.config/nvim/tmp/undo//     " undo files
set backupdir=~/.config/nvim/tmp/backup// " backups
set directory=~/.config/nvim/tmp/swap//   " swap files
set backup                                " enable backups
set noswapfile

" Wildmenu completion
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.hi                             " Haskell crap
set wildignore+=*.ibc                            " Idris crap
set wildignore+=*.dyn_hi,*.dyn_o
set wildignore+=*/dist/*

" FZF config
nnoremap æ :Files<CR>
nnoremap ç :Files ~<CR>
nnoremap â :Buffers<CR>
nnoremap í :Lines<CR>
nnoremap á :Rg<space>
nnoremap <space>f :Files<CR>
nnoremap <space>g :Files ~<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>m :Lines<CR>
nnoremap <space>a :Rg<space>
nnoremap <space>: :History:<CR>
nnoremap <space>/ :History/<CR>
augroup fzf_terminal
  autocmd!
  autocmd WinEnter,BufEnter fzf tnoremap <Esc> <C-\><C-n>:q<CR>
  autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end

" Completion

inoremap æ <C-n>


" Searching and movement --------------------------------------------------

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

nnoremap // :noh<CR>

" Made D behave
nnoremap D d$

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *<c-o>

" Insert line
nmap <leader>L o<Esc>HD80I-<Esc>I<Esc>

noremap H ^
noremap L g_


" Directional Keys

noremap j gj
noremap k gk

" Easy buffer navigation
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l

nnoremap è <C-w>h
nnoremap ê <C-w>j
nnoremap ë <C-w>k
nnoremap ì <C-w>l

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

tnoremap <A-q> <C-\><C-n>
"tnoremap <Esc><Esc> <C-\><C-n>
tnoremap ñ <C-\><C-n>

noremap <leader>v <C-w>v

" Easy tabs navigation
nnoremap <C-j> :tabp<CR>
nnoremap <C-k> :tabn<CR>
nnoremap <C-p> :tabp<CR>
nnoremap <C-n> :tabn<CR>
nnoremap ð :tabp<CR>
nnoremap î :tabn<CR>

nnoremap K <nop>

"----------------------------------------------------------------------
" Powerline configuration

" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
"
" "let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" "let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" "let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '␊'
" "let g:airline_symbols.linenr = '␤'
" "let g:airline_symbols.linenr = '¶'
" "let g:airline_symbols.maxlinenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" "let g:airline_symbols.branch = '⎇'
" "let g:airline_symbols.paste = 'ρ'
" "let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

"let g:lightline = { 'colorscheme': 'PaperColor' }
let g:lightline = { 'colorscheme': 'solarized' }

set ts=2
set sts=2
set sw=2
set expandtab

"----------------------------------------------------------------------
" Autogroups

augroup vimrc_filetype
autocmd!

autocmd FileType text setlocal nonumber norelativenumber
autocmd FileType text setlocal nolist showbreak=
autocmd FileType text setlocal foldcolumn=2

autocmd FileType yaml   setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType hamlet setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType lucius setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType julius setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType glsl   setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType nix    setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType vim    setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby   setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType javascript        setlocal ts=2 sts=2 sw=2
autocmd FileType c,html            setlocal ts=2 sts=2 sw=2
autocmd FileType haskell,coq,idris setlocal ts=4 sts=4 sw=4
autocmd FileType haskell,coq setlocal wrap cmdheight=1
autocmd FileType haskell setlocal foldcolumn=1
autocmd FileType haskell setlocal numberwidth=2
autocmd BufWritePre *.{hs,vim,nix,h,c} StripWhitespace

autocmd BufNewFile,BufRead *.{ts,tsx} set filetype=typescript
autocmd FileType c,java,cpp,python,ruby,json setlocal foldmethod=manual

autocmd BufWritePost $MYVIMRC nested so % | echom "Reloaded" | redraw

augroup END

" Colorscheme
"colorscheme SolarizedHaskell
syntax enable
syntax sync minlines=256
set background=dark
colorscheme solarized

" Whitespace
highlight ExtraWhitespace ctermbg=red
nmap <space>ds :StripWhitespace<CR>
nmap <leader>ds :StripWhitespace<CR>

