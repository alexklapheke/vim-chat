" ftplugin/chat.vim

setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

setlocal comments=n:%

if exists("b:chat_ca")
	setlocal matchpairs+=⌈:⌉
	setlocal matchpairs+=⌊:⌋
endif

