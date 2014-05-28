" ==================================== 
" Vim Setting
" ==================================== 
language C
syntax on
set number
set showmode
set showmatch
set noswapfile
set title
set ruler
set showmatch
set cursorline
set autoread
"set textwidth=0

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

" Edit vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

" ------------------------------------
" Pathogen
" ------------------------------------
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" ------------------------------------
" Vundle 
" ------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" original repos on github
Bundle 'vim-ruby/vim-ruby'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-rsense'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-rails'
Bundle 'taichouchou2/vim-rsense'
Bundle 'tpope/vim-endwise.git'
Bundle 'kana/vim-fakeclip.git'

" vim-scripts repos
Bundle 'project.tar.gz'

" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
Bundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

filetype plugin indent on

" ------------------------------------
" Cursorline 
" ------------------------------------
" draw cursorline only in current window
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" ------------------------------------
" Unite
" ------------------------------------
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" ------------------------------------
" Neocomplcache
" ------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_force_overwrite_completefunc=1

" Tab Complement
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" --------------------------------
" endwise
" -------------------------------
" For Neocomplcache
function! s:my_crinsert()
  return pumvisible() ? neocomplcache#close_popup() : "\<Cr>"
endfunction
inoremap <silent> <CR> <C-R>=<SID>my_crinsert()<CR>

" ------------------------------------
" Rails 
" ------------------------------------
"let g:rails_level=4
"let g:rails_default_file="app/controllers/application.rb"
"let g:rails_default_database="sqlite3"

" ------------------------------------
" vim-rsense
" ------------------------------------
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

" ------------------------------------
" vim -b : edit binary using xxd-format!
" ------------------------------------
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

"-----------------------------------
let NERDTreeIgnore = ['.aux$', '.dvi$', '.toc$']
"-----------------------------------


" ------------------------------------
" latex 
" ------------------------------------
"filetype plugin on
"let tex_flavor = 'latex'
"set grepprg=grep\ -nH\ $*
"set shellslash
""let g:Tex_DefaultTargetFormat = 'pdf' 
"let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*'
"let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
"let g:Tex_FormatDependency_pdf = 'dvi,pdf'

" from wiki http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Vim-LaTeX
filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FormatDependency_pdf = 'pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -l -u -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/texbin/dvipdfmx $*.dvi'
"let g:Tex_CompileRule_pdf = '/usr/local/bin/ps2pdf $*.ps'
let g:Tex_CompileRule_ps = '/usr/texbin/dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = '/usr/texbin/platex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_dvi = '/usr/texbin/uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = '/usr/texbin/pbibtex'
"let g:Tex_BibtexFlavor = '/usr/texbin/upbibtex'
"let g:Tex_BibtexFlavor = '/usr/texbin/bibtex'
"let g:Tex_BibtexFlavor = '/usr/texbin/bibtexu'
let g:Tex_MakeIndexFlavor = '/usr/texbin/mendex $*.idx'
"let g:Tex_MakeIndexFlavor = '/usr/texbin/makeindex $*.idx'
"let g:Tex_MakeIndexFlavor = '/usr/texbin/texindy $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a TeXShop.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a TeXworks.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Firefox.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a "Adobe Reader.app"'
let g:Tex_ViewRule_ps = '/usr/bin/open'
let g:Tex_ViewRule_dvi = '/usr/bin/open'
