" ftplugin/chat.vim

if !exists("b:minchat")
	let b:minchat = 0
endif

if !exists("b:chat_ca")
	let b:chat_ca = 0
endif

" Detect UTF-8 formatting (should probaby be used anyway)
if search('^@UTF8$', 'n') != 0
	setlocal fileencoding=utf-8
endif

" Adopt CHAT-CA Transcription (Sacks, Schegloff, & Jefferson 1974)
if search('^@Options:\s*\<CA\>', 'n') != 0
	let b:chat_ca = 1
endif

setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

setlocal comments=n:%

if exists("b:chat_ca")
	setlocal matchpairs+=⌈:⌉
	setlocal matchpairs+=⌊:⌋
endif

