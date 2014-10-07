" indent/chat.vim

setlocal indentexpr=GetChatIndent()
setlocal indentkeys=@,*,%,o,O,!^F

if exists("b:did_indent")
	finish
endif

function! GetChatIndent()
	let line = getline(v:lnum)

	if line =~ '^\s*[@*%]'
		return 0
	else
		return shiftwidth()
	endif
endfunction

let b:did_indent = 1

