"------------------------------------
" vim Default Setting
"------------------------------------
language C
:syntax enable
:set showmatch
:set number
:set noswapfile

" Indent
:set autoindent
" :set smartindent
:set expandtab
:set softtabstop=2
:set shiftwidth=2

" Clipbord
set clipboard+=unnamed

" Color
hi Pmenu ctermbg=2
hi PmenuSel ctermbg=5
"hi PmenuSbar ctermbg=2
"hi PmenuThumb ctermfg=3

"------------------------------------
" Pathogen
"------------------------------------
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

"------------------------------------
" Vundle 
"------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()

" original repos on github
Bundle 'vim-ruby/vim-ruby'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-rails'
Bundle 'taichouchou2/vim-rsense'
Bundle 'tpope/vim-endwise.git'
Bundle 'kana/vim-fakeclip.git'

" vim-scripts repos
Bundle 'project.tar.gz'


" non github repos
"Bundle 'git://git.wincent.com/command-t.git'


filetype plugin indent on

"------------------------------------
" Neocomplcache
"------------------------------------
let g:neocomplcache_enable_at_startup = 1

" Tab Complement
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" --------------------------------
" endwise
" -------------------------------

" Neocomplcache
function! s:my_crinsert()
  return pumvisible() ? neocomplcache#close_popup() : "\<Cr>"
endfunction
inoremap <silent> <CR> <C-R>=<SID>my_crinsert()<CR>

"------------------------------------
" Rails 
"------------------------------------
"let g:rails_level=4
"let g:rails_default_file="app/controllers/application.rb"
"let g:rails_default_database="sqlite3"

"------------------------------------
" vim-rsense
"------------------------------------
" Rsense
let g:rsenseUseOmniFunc = 1
let g:rsenseHome = expand('~/.vim/ref/rsense-0.3')

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  
function! SetUpRubySetting()
  setlocal completefunc=RSenseCompleteFunction
  nmap <buffer>tj :RSenseJumpToDefinition<CR>
  nmap <buffer>tk :RSenseWhereIs<CR>
  nmap <buffer>td :RSenseTypeHelp<CR>
endfunction
autocmd FileType ruby,eruby,ruby.rspec call SetUpRubySetting()

"------------------------------------
" vim -b : edit binary using xxd-format!
"------------------------------------
augroup Binary
  au!
  au BufReadPre  *.bin let &binary=1
  au BufReadPost * if &binary | %!xxd
  au BufReadPost * set ft=xxd | endif
  au BufWritePre * if &binary | %!xxd -r
  au BufWritePre * endif
  au BufWritePost * if &binary | %!xxd
  au BufWritePost * set nomod | endif
augroup END

"-----------------------------------
" netrw
"-----------------------------------
" netrwは常にtree view
let g:netrw_liststyle = 3
" CVSと.で始まるファイルは表示しない
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
