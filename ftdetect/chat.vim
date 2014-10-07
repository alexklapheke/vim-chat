" ftdetect/chat.vim
autocmd BufNewFile,BufRead *.cha setfiletype chat

" Detect UTF-8 formatting (should probaby be used anyway)
if search('^@UTF8$', 'n') != 0
	setlocal fileencoding=utf-8
endif

" Adopt CHAT-CA Transcription (Sacks, Schegloff, & Jefferson 1974)
if search('^@Options:\s*\<CA\>', 'n') != 0
	let chat_ca = 1
endif

