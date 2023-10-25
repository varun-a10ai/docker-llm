set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plug 'gmarik/Vundle.vim'
" Plug 'wincent/command-t'
" Bundle 'solarnz/thrift.vim'
" Plug 'fatih/vim-go'
" Plug 'Shougo/neocomplete.vim'
" Plug 'justmao945/vim-clang'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
"Plug 'Shougo/vimproc.vim'
"Plug 'Shougo/vimshell.vim'
Plug 'vim-utils/vim-man'
" Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
" Plug 'vim-scripts/calendar.vim--Matsumoto'
"Plug 'vitalk/vim-simple-todo'
"Plug 'tpope/vim-repeat'
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'ivanov/vim-ipython'
"Plug 'vim-scripts/a.vim'
"Plug 'w0rp/ale'
"Plug 'leafgarland/typescript-vim'
"Plug 'Quramy/tsuquyomi'
"Plug 'python-mode/python-mode.git'
"Plug 'itchyny/lightline.vim'
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'heavenshell/vim-pydocstring'
"Plug 'ludovicchabant/vim-gutentags' 
"Plug 'roxma/vim-tmux-clipboard'
" Plug 'chrisbra/unicode.vim'
" does not support async
Plug 'vim-syntastic/syntastic' 
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
" Plug 'varung/vim-ipythonsend'
" Plug 'tpope/vim-vinegar'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'yegappan/mru'

" jump to lines by indent, [-+= ]-+=
Plug 'jeetsukumaran/vim-indentwise'
"perhaps we don't need both of these
" Plug 'fholgado/minibufexpl.vim'
" Plug 'jlanzarotta/bufexplorer'
" Plug 'vim-scripts/repeatable-motions.vim'
Plug 'preservim/nerdtree'
Plug 'chrisbra/vim-autoread'
Plug 'junegunn/goyo.vim'
"Plug 'fatih/molokai'
Plug 'flazz/vim-colorschemes'
" Plug 'vim-scripts/YankRing.vim'
Plug 'dense-analysis/ale'

" Plug 'jupyter-vim/jupyter-vim'
" Plug 'xuhdev/vim-latex-live-preview'
" Plug 'tmhedberg/SimpylFold'
Plug 'varung/vim-open-url'
" needs to be yarn installed
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'tpope/vim-eunuch'
" include buftab line Plug
Plug 'ap/vim-buftabline'
Plug 'github/copilot.vim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'neovim/nvim-lspconfig'
" automaticall installs lsp servers
Plug 'williamboman/mason.nvim'

" All of your Plugins must be added before the following line
call plug#end()            " required


lua require("mason").setup()

filetype plugin on    " required

" CTRL+b opens the buffer list
map <C-b> <esc>:BufExplorer<cr>
" gz in command mode switches to next buffer and deletes current
map gz :bn \| bd #

" map <leader> bracket to move buffers 

map <leader>] :bnext<cr>
map <leader>[ :bprev<cr>

tnoremap <leader>] <C-\><C-N>:bnext<cr>
tnoremap <leader>[ <C-\><C-N>:bprev<cr>

filetype plugin indent on    " required

set sw=2
set ts=2
set ic
set expandtab
set smarttab
set cindent
" set comments=sl:/**,mb:\ *,elx:\ */
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set autoindent		" always set autoindenting on
set nobackup
set nowritebackup
set noswapfile
set ruler
set incsearch
set hlsearch
" allow buffers with changed content to be switched out of and stay hidden
set hidden
set mouse=a
" autocomplete search subdirectories
set path+=**
set wildmenu
"set relativenumber
"set nu
set statusline=win:%{winnr()}
set statusline+=\ file:%f\ line:%l\ buffer:%n
set statusline+=%m
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set foldmethod=indent
set foldignore=
set nofoldenable
set directory=~/.vim//
set clipboard=unnamed


let g:tagbar_left=1
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction
command! TrimWhitespace call TrimWhitespace()

if has("autocmd")
  filetype plugin indent on
  autocmd FileType text setlocal textwidth=90
  augroup filetype_py
    autocmd!
    autocmd FileType python set foldmethod=indent shiftwidth=4
  augroup end
  autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call TrimWhitespace()
  autocmd FileType vimwiki set foldmethod=syntax textwidth=100
endif " has("autocmd")

let g:ctrlp_working_path_mode = 0

" vimwiki settings
let g:vimwiki_list = [{
	\'path': '$HOME/Dropbox/vimwiki',
	\'template_path': '$HOME/Dropbox/vimwiki/templates/',
	\'template_default': 'default',
	\'syntax': 'default',
	\'ext': '.md',
	\'path_html': '$HOME/Dropbox/vimwiki/site_html/',
	\'template_ext': '.html',
  \'auto_tags': 1, 'auto_export': 1,
  \'auto_diary_index': 1}]

let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,img,script'
let g:tagbar_type_vimwiki = { 'ctagstype':'vimwiki', 'kinds':['h:header'], 'sro':'&&&' , 'kind2scope':{'h':'header'} , 'sort':0 , 'ctagsbin':'~/.vim/vwtags.py' }

" custom mappings
command! -nargs=+ Vwt execute 'VimwikiSearchTags <args>' | lopen
iab <expr> ts; strftime("%T")
iab <expr> dt; strftime("%D")
tnoremap <esc> <C-\><C-n>
tnoremap <esc><esc> <c-\><c-n>
set whichwrap=h,l

" these actually end up mapping to <ESC> x which sends the meta key
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
"inoremap <A-h> <C-\><C-N><C-w>h
"inoremap <A-j> <C-\><C-N><C-w>j
"inoremap <A-k> <C-\><C-N><C-w>k
"inoremap <A-l> <C-\><C-N><C-w>l
"nnoremap <A-h> <C-w>h
"nnoremap <A-j> <C-w>j
"nnoremap <A-k> <C-w>k
"nnoremap <A-l> <C-w>l

function! SendToTerm() range
  " find channel for terminal buffer
  " if multiple terminal buffers exist, use the last one
  " send the selected text to the terminal
  let l:channel = 0
  let l:buf = 0
  for l:buf in range(1, bufnr('$'))
    " if g:terminal_buffer defined and is equal to l:buf
    if exists('g:terminal_buffer') && g:terminal_buffer != l:buf
      continue
    endif

    " echo bufname(l:buf) getbufvar(l:buf, '&buftype')
    if getbufvar(l:buf, '&buftype') == 'terminal'
      let l:channel = getbufvar(l:buf, '&channel')
      " echo l:buf bufname(l:buf) getbufvar(l:buf, '&buftype') l:channel
    endif
  endfor

  " print out channel number for debugging
  " echo l:channeL

  let l:data = join(getline(a:firstline, a:lastline),"\r\n")
  call chansend(l:channel, "\e[200~\n\r\n"..l:data.."\r\n\e[201~\<CR>")
endfunction
nnoremap <leader>ei :call SendToTerm()<cr>
" why extra apostrophe? see :h map-<leader>
vnoremap <leader>ei :call SendToTerm()<cr>
noremap <leader>mm :MRU<cr>


command! Ish :rightb vsplit term://$SHELL

tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <C-w>"" <C-\><C-n>pi
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
tnoremap <C-PageUp> <C-\><C-n><C-PageUp>
tnoremap <C-PageDown> <C-\><C-n><C-PageDown>
tnoremap <C-v> <C-\><C-n>pi
command! Conf :e $MYVIMRC


function! SwapBuffers()
  let l:owin = win_getid(v:count)
  echo "swap buffers" . l:owin
  let l:bufo = winbufnr(v:count)
  let l:buf2 = bufnr()

  execute 'b' l:bufo
  " end up in other window, same buffer
  " switch to other window
  " call win_gotoid(l:owin)
  " execute 'b' l:buf2

  " stay in same window, but other buffer
  call win_execute(l:owin, 'b' . l:buf2)
endfunction

command! -nargs=1 SwapBuffers call SwapBuffers(<f-args>)
:nnoremap <C-W>x :<C-U>call SwapBuffers()<CR>

function! SetTerminalBuffer()
  let g:terminal_buffer = bufnr()
  " start insert mode
  execute('startinsert')
endfunction

command! SetTerminalBuffer call SetTerminalBuffer()
autocmd BufEnter * if &buftype == 'terminal' | :call SetTerminalBuffer() | endif

let g:miniBufExplVSplit = 30
let g:miniBufExplBRSplit = 0

command! Recent :new | :set ts=80 | r ! ~/Dropbox/vimwiki/findnewest.sh


" LATEX
let g:vimtex_view_method = 'zathura'

nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^

vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^



nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
"nnoremap <Leader>b :bp<CR>
tnoremap <Leader>b <C-\><C-n>:bp<CR>

nnoremap <Leader>f :bn<CR>
tnoremap <Leader>f <C-\><C-n>:bn<CR>

" list allow choosing
nnoremap <Leader>l :ls<CR>:b<space>
map <C-b> <esc>:ls<CR>:b<space>
map <C-a> ggVG

colorscheme zellner

" Copilot Mappings
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-K> copilot#Next()
let g:copilot_no_tab_map = v:true

" solve syntax highlighting failing halfway through
syntax sync fromstart

" make buftabline show buffer numbers
let g:buftabline_numbers = 1
" set buftabline to show separators
let g:buftabline_separators = 1
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(-1)

"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(&modified)
      let answer = confirm("This buffer has been modified.  Are you sure you want to delete it?", "&Yes\n&No", 2)
      if(answer != 1)
        return
      endif
    endif
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call s:Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

" Create a mapping (e.g. in your .vimrc) like this:
nmap <C-W>! <Plug>Kwbd

set noequalalways
set splitright
set splitbelow

nnoremap <F8> :TagbarOpenAutoClose<CR>
nnoremap <F9> :NERDTreeToggle<CR>
:set nofixendofline

lua require('init')
