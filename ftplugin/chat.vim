" ftplugin/chat.vim

setlocal tabstop=8
setlocal noexpandtab

if exists("chat_ca")
	setlocal matchpairs+=⌈:⌉
	setlocal matchpairs+=⌊:⌋
endif

