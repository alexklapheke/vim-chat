" ftplugin/chat.vim

if !exists("b:minchat")
	let b:minchat = 0
endif

if !exists("b:chat_ca")
	let b:chat_ca = 0
endif

if !exists("b:berkeley")
	let b:berkeley = 0
endif

if !exists("g:colorParticipants")
	let g:colorParticipants = 1
endif

" Detect UTF-8 formatting (should probably be used anyway)
if search('^@UTF8$', 'n') != 0
	setlocal fileencoding=utf-8
endif

" Adopt CHAT-CA Transcription (Sacks, Schegloff, & Jefferson 1974)
if search('^@Options:\s*\<CA\>', 'n') != 0
	let b:chat_ca = 1
endif

" Adopt Berkeley Transcription System (Slobin et al. 2001)
" I don't know if this is a conventional way to mark this.
if search('^@Options:\s*\<BTS\>', 'n') != 0
	let b:berkeley = 1
endif

setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

setlocal comments=n:%
setlocal matchpairs+=<:>

if b:chat_ca
	setlocal matchpairs+=⌈:⌉
	setlocal matchpairs+=⌊:⌋
endif

