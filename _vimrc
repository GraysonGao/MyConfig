"关闭兼容模式
set nocompatible

" ====================== 判断操作系统, 以及是否为Gvim  =====================
" 判断是 Windows 还是 Linux.
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif
" 判断是终端还是 Gvim
let g:isGUI = 1
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" ====================== Vim 原有的配置 =======================
"  Windows Gvim 的原有配置, 修改了一下
if (g:iswindows && g:isGUI)
    "模仿windows快捷键
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    " Vim 原有配置, Vimdiff相关, 但是总是报错, 所以注释掉了
"    function MyDiff()
"        let opt = '-a --binary '
"      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"      let arg1 = v:fname_in
"      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"      let arg2 = v:fname_new
"      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"      let arg3 = v:fname_out
"    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"     let eq = ''
"     if $VIMRUNTIME =~ ' '
"       if &sh =~ '\<cmd'
"        let cmd = '""' . $VIMRUNTIME . '\diff"'
"       let eq = '"'
"    else
"     let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"     endif
"    else
"      let cmd = $VIMRUNTIME . '\diff'
"    endif
"   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
" endfunction
" set diffexpr=MyDiff()
endif
" Linux Gvim/Vim 默认配置, 做了一点修改
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif
        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

" 自动加载修改过后的vimrc
autocmd! bufwritepost _vimrc source %

" ================================= 自定义配置 =====================================
"----------------------------------UI和主题-------------------------------------------
"设置字体，在Linux中这样设置：set guifont=Courier\ 16
if(g:iswindows)
    set guifont=Consolas:h14
elseif(g:islinux)
    set guifont=Courier\ 16
endif
"设置行宽为100字符
set textwidth=100
"开启行号，简写 set nu
set number
"开启语法高亮
syntax enable
syntax on
"显示tab, 换行和空格
set list
set listchars=tab:>-,trail:-
"突出显示当前行
set cursorline
"windows下启动vim最大化
if (g:isGUI)
    autocmd GUIEnter * simalt ~x
endif
"windows下关闭工具栏和滚动条
if(g:isGUI)
    "关闭工具栏
    set guioptions-=T
    "关闭右侧滚动条
    set guioptions-=r
    "关闭菜单
    set guioptions-=m
endif

"----------------------------------编码---------------------------------
"设置vim内部编码
set encoding=utf-8
"设置编辑文件时的编码
set fileencoding=utf-8
"设置终端编码为Vim内部编码
"let &termencoding=&encoding
set termencoding=utf-8
"设置可识别的编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,big5,cuc-jp,cuc-kr,latin1
"防止特殊符号无法显示
set ambiwidth=double
"解决菜单乱码, 以及关闭滚动条, 工具栏
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif
"解决console输出乱码
language messages zh_CN.utf-8

"--------------------------------Tab和缩进-------------------------------------
"开启自动缩进
set autoindent
"智能缩进
set smartindent
"缩进尺寸为4个空格
set shiftwidth=4
"Tab键相当于4个空格
set tabstop=4
"set ts=4
set expandtab
"在行和段开始处使用制表符
set smarttab

"----------------------------------搜索和匹配---------------------------------
""高亮显示搜索到的关键字
set hlsearch
"即时搜索
"set incsearch
""高亮显示匹配的括号 
set showmatch
"智能大小写敏感, 只要有一个字母大写, 就大小写敏感, 否则不敏感
set ignorecase smartcase

"----------------------------------保存和备份-----------------------------------------
"不生成备份文件
set nobackup
"不生成临时文件
set noswapfile
"自动重新加载外部修改内容
set autoread

"----------------------------------操作习惯和快捷键配置---------------------------------
" 将Esc配置成kk
inoremap kk <Esc>
"ctrl-h-h:将光标移动到行首
"inoremap <c-h>h <Home>
"ctrl-l-l:将光标移动到行尾 
"inoremap <c-l>l <End>
"Ctrl + H 将光标移到当前行的行首
"imap <c-h> <ESC>I
"Ctrl + J 将光标移到下一行的行首
"imap <c-j> <Down><ESC>I
"Ctrl + K 将光标移到上一行的末尾
"imap <c-k> <Up><ESC>A
"Ctrl + L 将光标移到当前行的行尾
"imap <c-l> <ESC>A
"Alt + h  光标左移一格
imap <m-h> <Left>
"Alt + j  垂直下移一行
imap <m-j> <Down>
"Alt + k  垂直上移一行
imap <m-k> <Up>
"Alt + L  光标右移一格
imap <m-l> <Right>
"对于很长的行, vim会自动换行, 此时 j 或者 k 就会
"一下跳很多行, gk,gj 可以避免这个问题, 但是不方便.
"map k gk
"map j gj

" ============================== 插件配置 =========================================
" -----------------------------使用vundle管理插件-----------------------------------
filetype off
filetype plugin indent on
if(g:iswindows)
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    let path='$VIM/vimfiles/bundle'
    call vundle#begin(path)
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
endif
" ----------------------------配置vundle需要安装的插件------------------------------
" 三种形式: 1. 写它在Github上的名字: 作者名/项目名
"           2. 写它在Github上的地址: git://..../xxx.git
"           3. 写它在VimScript上的地址(http://vim-scripts.org/vim/scripts.html)
Plugin 'gmarik/Vundle.vim'
" 目录树插件
Plugin 'scrooloose/nerdtree'
" 配色方案, 如果不起效果的话, 就把该主题下载下来，并安装到vimfiles-colors中
Plugin 'tomasr/molokai'
" session 管理
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-session'
" --------------------------------------------------------------------------------
" 更好看/强大的命令模式
"Plugin 'Lokaltog/vim-powerline'
" 不知道干啥的...
"Plugin 'tpope/vim-fugitive'
" 快速移动
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'mrtazz/molokai.vim'
"Plugin 'L9'
"Plugin 'FuzzyFinder'
"Plugin 'grep.vim'
"Plugin 'genutils'
"Plugin 'lookupfile'
"Plugin 'ShowMarks'
"Plugin 'SuperTab'
"Plugin 'surround.vim'
"Plugin 'Tagbar'
"Plugin 'taglist.vim'
"代码片段插件
"Plugin 'UltiSnips'
"写网页必备插件
"Plugin 'mattn/emmet-vim'
"Plugin 'ctrlp.vim'
"Plugin 'EasyGrep'
" CtrlP, YouComplete, vimIM, zen conding, vimwiki
call vundle#end()

"--------------------------------配置主题-----------------------------------------
colorscheme molokai
"let g:molokai_original = 1
let g:rehash256 = 1

"--------------------------------配置vim-session------------------------------------
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

"--------------------------------配置nerd tree-----------------------------------
"默认显示隐藏文件
let NERDTreeShowHidden=1
"默认显示行号
let NERDTreeShowLineNumbers=1
" 普通模式下输入 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>
