" type 'PlugInstall' in vim
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
call plug#end()

set tags=./tags,tags;/

" for linux kernel style  
" --------------- 
" 设置自动换行
set wrap
" 设置制表符宽度
set tabstop=8
" 设置缩进宽度
set shiftwidth=8
" 设置文件宽度，以便长行自动折行显示
autocmd FileType c setlocal colorcolumn=81
autocmd BufRead,BufNewFile *.h set filetype=c
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" ----------------   

set number
set relativenumber

"enable the search before typing Enter"
set incsearch
"enable highlight while searching"
set hlsearch

"disable highlight with binding it to \h"
nnoremap \h :nohlsearch<CR>

"disable relativenumber with binding it to \w"
function! Setnumber(mode)
	if a:mode == 0
		set nonumber
		set norelativenumber
	else
		set number
		set relativenumber
	endif
endfunction

nnoremap \w :call Setnumber(0)<CR>
nnoremap \W :call Setnumber(1)<CR>

set clipboard=unnamed,unnamedplus

set autoindent

set laststatus=2
set statusline=%f%=%m%{&fileencoding}\ \ \ %=%c\ %l/%L

syntax on

highlight ColorColumn ctermbg=Green guibg=NONE
highlight Comment ctermfg=DarkCyan
highlight Preproc ctermfg=LightMagenta
highlight Macro ctermfg=Brown
highlight StatusLine ctermfg=DarkYellow ctermbg=Black term=Bold
highlight MatchParen ctermfg=Cyan ctermbg=DarkGray
highlight markdownItalic ctermfg=LightMagenta
highlight markdownBold ctermfg=Brown
highlight markdownBoldItalic ctermfg=Cyan
highlight Title ctermfg=DarkYellow
highlight directory ctermfg=Green

let g:global_string = ""

map <C-f> :call SearchWordReference(GetString(0))<CR><C-o>/<C-r>=g:global_string<CR><CR><C-o><C-l>
vmap <C-f> :call SearchWordReference(GetString(1))<CR><C-o>/<C-r>=g:global_string<CR><CR><C-o><C-l>

map <C-h> :cs find g <C-r>=GetString(0)<CR><CR>
vmap <C-h>:cs find g <C-r>=GetString(1)<CR><CR>

function! GetVisualString()
	let start = getpos("'<")[2]
	let end = getpos("'>")[2]
	let line = getline('.')
	return line[start-1 : end-1]
	endif
endfunction

function! GetString(mode)
	if a:mode == 0
		let search_query = expand('<cword>')
	else
		let search_query = escape(GetVisualString(),".*^$[]? \\")
	endif
	let g:global_string = search_query
	return search_query
endfunction

function! SearchWordReference(string)
	let search_query = a:string
	let header_file = "**/*.h"
	let source_file = "**/*.c"
	let h_exsist = !empty(glob(header_file,0,1))
	let c_exsist = !empty(glob(source_file,0,1))

	if (h_exsist == 1 && c_exsist == 1)
		execute 'vimgrep /' . search_query . '/g' . header_file . ' ' . source_file
		cclose
	elseif (h_exsist == 1 && c_exsist == 0)
		execute 'vimgrep /' . search_query . '/g' . header_file
		cclose
	elseif (h_exsist == 0 && c_exsist == 1)
		execute 'vimgrep /' . search_query . '/g' . source_file
		cclose
	else
		echo search_query . " no reference found"
	endif
endfunction

function! SearchReference(string, file)
	let search_query = a:string
	let exsist = !empty(glob(a:file,0,1))

	if (exsist == 1)
		execute 'vimgrep /' . search_query . '/g' . a:file
		cclose
	else
		echo search_query . " no reference found"
	endif
endfunction

nnoremap <C-l> :vertical rightbelow 70copen<CR>
nnoremap <C-c> :cclose<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

set autowrite
set autoread

map <C-g> :%s/<C-r>=GetString(0)<CR>/
vmap <C-g> :<C-u>%s/<C-r>=GetString(1)<CR>/
map <C-i> :call SearchReference(GetString(0), '
map ; :
map q :q<CR>
map Q :q!<CR>

function! Translate(text)
    let translated_text = system('translate ' . shellescape(a:text) . ' -b')
	echo translated_text
endfunction

map t :call Translate(GetString(0))<CR>
vmap t :call Translate(GetVisualString())<CR>

map <C-\> <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_new_tab = 0

" tab
map g1 :tabn 1<CR>
map g2 :tabn 2<CR>
map g3 :tabn 3<CR>
map g4 :tabn 4<CR>
map g5 :tabn 5<CR>
map g6 :tabn 6<CR>
map g7 :tabn 7<CR>
map g8 :tabn 8<CR>
map g9 :tabn 9<CR>
map g0 :tablast<CR>

" restore last position of file
if has("autocmd")
	    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
