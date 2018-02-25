" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

"function! GoogleCppIndent()
"    let l:cline_num = line('.')
"    let l:orig_indent = cindent(l:cline_num)
"    if l:orig_indent == 0 | return 0 | endif
"    let l:pline_num = prevnonblank(l:cline_num - 1)
"    let l:pline = getline(l:pline_num)
"    if l:pline =~# '^\s*template' | return l:pline_indent | endif
"    if l:orig_indent != &shiftwidth | return l:orig_indent | endif
"    let l:in_comment = 0
"    let l:pline_num = prevnonblank(l:cline_num - 1)
"    while l:pline_num > -1
"        let l:pline = getline(l:pline_num)
"        let l:pline_indent = indent(l:pline_num)
"
"        if l:in_comment == 0 && l:pline =~ '^.\{-}\(/\*.\{-}\)\@<!\*/'
"            let l:in_comment = 1
"        elseif l:in_comment == 1
"            if l:pline =~ '/\*\(.\{-}\*/\)\@!'
"                let l:in_comment = 0
"            endif
"        elseif l:pline_indent == 0
"            if l:pline !~# '\(#define\)\|\(^\s*//\)\|\(^\s*{\)'
"                if l:pline =~# '^\s*namespace.*'
"                    return 0
"                else
"                    return l:orig_indent
"                endif
"            elseif l:pline =~# '\\$'
"                return l:orig_indent
"            endif
"        else
"            return l:orig_indent
"        endif
"
"        let l:pline_num = prevnonblank(l:pline_num - 1)
"    endwhile
"    return l:orig_indent
"endfunction


" line
" set cursorline
set hls
"允许插件
"filetype plugin on

"共享剪贴板
set clipboard+=unnamed

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noswapfile
set expandtab
set wrap
set cindent
set cinoptions=h1,l1,g1,t0,i2,+2,(2,w1,W2
"set indentexpr=GoogleCppIndent()
let b:undo_indent = "setl sw< ts< sts< et< tw< wrap< cin< cino< inde<"
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencodings=utf-8

"始终显示状态栏
set laststatus=2

" =========
" 环境配置
" =========

" 设定 mapleader 
let mapleader = ";"
let g:mapleader = ";"
let maplocalleader = ";"

" 保留历史记录
set history=500

" 行控制
set linebreak
set nocompatible

" 标签页
set tabpagemax=9
set showtabline=0

" 控制台响铃
set noerrorbells
set novisualbell
set t_vb= "close visual bell

" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" 命令行于状态行
set ch=1
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PATH]\ %r%{GetPWD()}%h\ %=\ [Line]%l/%L\ %=\[%P]
set ls=2 " 始终显示状态行
set wildmenu "命令行补全以增强模式运行

"高亮搜索结果 搜索
set hlsearch  " Highlight search things
"打开正则表达式
set magic     " Set magic on, for regular expressions
"显示匹配的括号
set showmatch " Show matching bracets when text indicator is over them
set mat=2     " How many tenths of a second to blink
"实时搜索
set incsearch
"忽略大小写
set ignorecase

"显示当前所处模式
set showmode

" 制表符
set tabstop=4
set expandtab
"set smarttab
" google style use 2 space for tab and retraction 
set shiftwidth=4
set softtabstop=4

" 状态栏显示目前所执行的指令
set showcmd 

" 缩进
set autoindent
set smartindent
set wrap

"set vim screen width
vertical res 800 

"设置当文件被改动时自动载入, 自动重新读入
set autoread

"设置退出插入模式后自动保存
set autowrite

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 设定在任何模式下鼠标都可用
" set mouse=a

" 备份和缓存
set nobackup
set nowb
set noswapfile

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu

" 代码折叠
set foldmethod=marker

" 右下角显示列号
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" =====================
" 多语言环境
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif


" =============
" Color Scheme
" =============
if has('syntax')
    if (has("gui_running"))
        set guioptions-=m
        set guioptions-=T
        colorscheme desert
    else
        colorscheme desert
        "colorscheme darkblue
    endif

    " 保证语法高亮
    syntax on
endif

syntax on

" =========
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on

    " JavaScript 语法高亮
    au FileType tpl,phtml,html,javascript let g:javascript_enable_domhtmlcss = 1
    au BufRead,BufNewFile *.js setf jquery

    " 给各语言文件添加 Dict
    let s:dict_dir = $HOME."/.vim/dict/"
    let s:dict_dir = "setlocal dict+=".s:dict_dir

    au FileType php exec s:dict_dir."php_funclist.dict"
    au FileType css exec s:dict_dir."css.dict"
    au FileType javascript exec s:dict_dir."javascript.dict"

    " 格式化 JavaScript 文件
    "au FileType javascript map <f12> :call g:Jsbeautify()<CR>
    "au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    
    au FileType php set omnifunc=phpcomplete#CompletePHP
    let php_sql_query=1                                                                                        
    let php_htmlInStrings=1

    " CSS3 语法支持
    au BufRead,BufNewFile *.css set ft=css syntax=css3

    " LESS 语法支持
    au BufNewFile,BufRead *.less set filetype=less
    
    au BufNewFile,BufRead *.phtml set filetype=html
    au BufNewFile,BufRead *.tpl set filetype=html

    " 将指定文件的换行符转换成 UNIX 格式
    au FileType php,javascript,phtml,html,css,python,vim,vimwiki set ff=unix
    au FileType python set makeprg="python -u %"

    " JSON 语法高亮
    au! BufRead,BufNewFile *.json setfiletype json
endif


" =========
" 图形界面
" =========
if has('gui_running')
    " 高亮光标所在的行
    " set cursorline

    " 设置行高
    set linespace=2

    " Under Linux/Unix etc.
    if has("unix") && !has('mac')
        set guifont=Courier\ 10\ Pitch\ 11
    endif

    " Under the Mac(MacVim)
    if has("mac")
        " 开启抗锯齿渲染
        set anti

        " MacVim 下的字体配置
        set guifont=M+_1m_light:h16
        "set guifontwide=STHeiti_Medium:h14

        " 半透明和窗口大小
        set transparency=2
        set lines=200 columns=140

        " 使用 MacVim 原生的全屏幕功能
        let s:lines=&lines
        let s:columns=&columns

        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf

        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf

        "set guioptions+=e
        " Mac 下，按 <leader>ff 切换全屏
        nmap <leader>ff  :call FullScreenToggle()<CR>

        " Set input method off
        set imdisable

        " 如果为空文件，则自动设置当前目录
        lcd ~/Downloads/
    endif
endif


" =========
" 插件设置
" =========

" Netrw
let g:netrw_winsize = 30

" NERD_Commenter
let NERDShutUp=1

" Grep
let Grep_Default_Filelist = '*.hpp *.cc *.cpp *.h *.php *.js *.css *.html *.phtml *.py'

" Doxygen Toolkit
let g:DoxygenToolkit_authorName=" wusheng Hu"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_php_settings = 'php;c:class;f:function;d:constant'
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 30
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 
nmap tl :TlistToggle<CR>

" Taglist
set tags=tags;
set autochdir
map <C-F9> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
"set list
"set listchars=tab:>-,trail:-
""set ignorecase 
set noswapfile

" 使用NERDTree插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=18
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" WinManager
let g:NERDTree_title='[NERD Tree]'
let g:AutoOpenWinManager= 1
let g:winManagerWindowLayout='NERDTree'
"let g:winManagerWindowLayout='NERDTree|TagList'
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap wm :WMToggle<cr>
function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction

" SuperTab
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"

" MiniBufExplorer
let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
"let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplorerMoreThanOne=0

" NeoComplCache 自动补全
"let g:neocomplcache_enable_at_startup=1   

"高亮当前列
set cursorcolumn

" =========
" 键盘映射
" =========
" 定义快捷键的前缀，即<Leader>
"let mapleader=";"
 
" 定义快捷键 跳转到当前行的行首
nmap lg 0
" 定义快捷键 跳转到当前行的行尾
nmap le $
" 定义快捷键 关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键 保持当前窗口内容
nmap <Leader>w :w<CR>
" 设置快捷键 将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键 将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p
" 设置快捷键 进行工程编译及链接，并同时在quickfix输出make结果
" 前提是工程目录中有Makefile文件
nmap <Leader>m :wa<CR>:make<CR>:bot cw<CR><CR>
 
" 定义快捷键 跳转到光标所在关键词的定义处
nmap <Leader>gt <C-]>
" 定义快捷键 跳回原关键词 与 ;gr 配合使用
nmap <Leader>gr <C-T>
" 定义快捷键 跳到当前屏幕倒数第二行
nmap <Leader>gf <C-f>
" 定义快捷键 跳到当前屏幕第二行
nmap <Leader>gb <C-b>
"快速切换C H源文件
nmap <Leader>cd :A<CR>
" 使用Grep.vim插件在工程内全局查找，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :Grep<CR>
" 设置快捷键gs遍历各分割窗口。快捷键速记法：goto the next spilt window
nnoremap <Leader>gs <C-W><C-W>
" 取消补全内容以分割子窗口形式出现，只显示补全列表
set completeopt=longest,menu

"cs add $curpwd/cscope.out $curpwd/
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" VIM支持多种文本折叠方式，我VIM多用于编码，所以选择符合编程语言语法的代
"码方式。
set foldmethod=syntax
" 启动vim时打开所有折叠代码。
set nofen

"F3全工程内搜索匹配字符串
nnoremap <silent> <F3> :Grep<CR><CR><CR>

"nnoremap <silent> <F3> :A<CR>
let cwd=""
"cs add cscope.out

let g:miniBufExplMapWindowNavArrows = 1
"允许光标在任何位置时用CTRL-TAB遍历buffer
"let g:miniBufExplMapCTabSwitchBufs = 1

" 打开或关闭quickfix 并设置quickfix始终在屏幕底层
nmap <Leader>cw :bot cw<CR>

" 解决中文乱码问题
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"set termencoding=big5
"测试中文显示是否正常,這是繁體中文

" 重新打开文档时光标回到文档关闭前的位置
if has("autocmd")
 autocmd BufReadPost *
 \ if line("'\"") > 0 && line ("'\"") <= line("$") |
 \ exe "normal g'\"" |
\ endif
endif

":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>

"nmap <silent> <F3> :Grep<CR>
nmap <silent> <F8> :A<CR>
nmap <silent> <F11> :cw<CR> 
nmap <silent> <F10> :ccl<CR> 
nmap <silent> <leader>n :noh<CR>
nmap <silent> <leader>w :w<CR>
nmap <C-p> :cp<CR>
nmap <C-n> :cn<CR>
nmap J <C-d>
nmap K <C-u>

" Netrw
nmap <silent> <leader>fe :Sexplore!<CR> 

" NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<cr>

" Doxygen Toolkit
map <F2>l :DoxLic<CR>
map <F2>a :DoxAuthor<CR>
map <F2>f :Dox<CR>
map <F2>b :DoxBlock<CR>
map <F2>c $a<TAB><TAB><TAB><TAB><TAB>/**<  */<Left><Left><Left>
"map <F11> :set paste<jR>
map <F12> :set nopaste<CR>

nmap    w=  :resize +3<CR>
nmap    w-  :resize -3<CR>
nmap    w,  :vertical resize -3<CR>
nmap    w.  :vertical resize +3<CR>
" WinManager
nmap <leader>t :WMToggle<CR>


augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end
" Google code style
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

"自动插入文件头
autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.py exec ":call SetTitle()"
func SetTitle()
    if expand("%:e") == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif expand("%:e") == 'py'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    elseif expand("%:e") == 'cpp'
        call setline(1,"#include <iostream>")
        call append(line("."), "")
    elseif expand("%:e") == 'cc'
        call setline(1,"#include <iostream>")
        call append(line("."), "")
    elseif expand("%:e") == 'c'
        call setline(1,"#include <stdio.h>")
        call append(line("."), "")
    elseif expand("%:e") == 'h'
        call setline(1, "#pragma once")
    elseif expand("%:e") == 'hpp'
        call setline(1, "#pragma once")
    endif
endfunc
autocmd BufNewFile * normal G

"c++11 
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error=1

"vim-json,取消vim-json
let g:vim_json_syntax_conceal = 0
