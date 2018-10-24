set nocompatible

filetype off
call pathogen#infect()
"call pathogen#helptags()
"filetype plugin indent on

syntax on
let g:gruvbox_bold=0
set background=dark
"colorscheme solarized
colorscheme gruvbox

"set transparent background
hi Normal ctermbg=none

let g:netrw_bufsettings = 'noma nomod nu nobl norap ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,Z?,V>
set number
set autoindent
set shiftround

set scrolloff=4
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set noerrorbells
set title
"set laststatus=2
set history=50
set ruler
set showcmd
set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault
set mouse=a
"set list
set listchars=tab:▸\ ,eol:¬
set pastetoggle=<F2>

let g:Powerline_symbols = 'fancy'
"set backupdir=~/.vim/tmp/backups
set undodir=~/.vim/tmp/undos
"set directory=~/.vim/tmp/swap
set nobackup
set noswapfile

let mapleader="\<Space>"
let maplocalleader="\\"

"set grepprg=grep/ -nH/ $*
"let g:tex_flavor = "latex"

nnoremap <leader>; :
nnoremap <leader>n :setlocal number!<cr>
nnoremap <leader>, :w<cr>
nnoremap <leader><space> :w !sudo tee %<cr>
"nnoremap <leader>l :setlocal list!<cr>
nnoremap <leader>l :nohl<cr>
nnoremap <leader>d 0
nnoremap <leader>n $
nnoremap <leader>h 15j
nnoremap <leader>t 15k
nnoremap <leader>q :q!<cr>
"nnoremap <leader>t :tabnew<cr>:E<cr>
"nnoremap <leader>, :tabclose<cr>
nnoremap <leader>v :vnew<cr>:E<cr>
nnoremap <leader>ss :new<cr>
nnoremap <leader>u :E<cr>

nnoremap - ddp
nnoremap _ dd2kp
imap <c-u> <esc>viwUA
nmap <c-u> viwU
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>'' :e ~/.Xresources<cr>
nnoremap <leader>c :wq<cr>
iabbrev @@ kaifrondorf@gmail.com
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
no d h
no h j
no t k
no n l
no e d
no j e
no K N
no k n
no , w

augroup netrw_dvorak_fix
    autocmd!
    autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
augroup END
function! Fix_netrw_maps_for_dvorak()
    noremap <buffer> d h
    noremap <buffer> h j
    noremap <buffer> t k
    noremap <buffer> n l
    "noremap <buffer> e d
    "noremap <buffer> j e
    "noremap <buffer> K N
    "noremap <buffer> k n
    "nnoremap <buffer> l t
    "noremap <buffer> E D
endfunction

"nnoremap <C-H> :%! xxd<CR>
