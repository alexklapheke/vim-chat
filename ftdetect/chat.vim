" ftdetect/chat.vim
autocmd BufNewFile,BufRead *.cha setfiletype chat

" Adopt CHAT-CA Transcription (Sacks, Schegloff, & Jefferson 1974)
if search('^@Options:\s*\<CA\>', 'n') != 0
	let chat_ca = 1
endif

