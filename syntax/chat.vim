" Vim syntax file
" Language: CHAT transcription format
" Maintainer: Alex Klapheke <alexklapheke@gmail.com>
" License: GPL v2
" Updated: 7 Oct 2014
" TODO: Implement matchparen-style highlighting for CHATinterrupt brackets

" Don't supersede an already-loaded syntax file
if exists("b:current_syntax")
	finish
endif

syntax case match

" metadata at top of file
syntax region CHATatheader    start=/^@/ end=/^[*%]\@=/ contains=CHATatheadertag,CHATsep,CHATsyntaxerror,@CHATparticipants
syntax match  CHATatheadertag /^@[^:]\+:\?/             contained

" main transcription data
syntax region CHATmainline     start=/^\*/ end=/\%$/ transparent    contains=CHATmainlinetag,CHATmainlinedata,CHATpostcode,CHATtimestamp,CHATsyntaxerror,CHATunintelligible,CHATinterrupt,CHATpitchmark
syntax match  CHATmainlinedata /\%(^\*\w\+:\|^\s\+\)\@<=[^·•]*/ containedin=CHATmainline
syntax match  CHATmainlinetag  /^\*\w\+:/                           containedin=CHATmainline contains=@CHATparticipants
syntax match  CHATcommentsdata /\%(^%\w\+:\s\+\)\@<=.*/

syn keyword CHATunintelligible xxx
syn match   CHATunintelligible /&\w\+/             containedin=CHATmainlinedata
syn match   CHATevent          /&=[A-Za-z0-9_:]\+/ containedin=CHATmainlinedata
syn match   CHATevent          /&[{}]\(\a\)=\w\+/  containedin=CHATmainlinedata
syn match   CHATpause          /(\.\+)/            containedin=CHATmainlinedata

if exists("b:chat_ca")
	syntax match CHATinterrupt /[⌈⌉⌊⌋]/ containedin=CHATmainline
	syntax match CHATpitchmark /[§°·āšʔʕʰΫạἩ„‡⁇⁎↑→↓↗↘↻⇗⇘∆∇∞∫∲∾≈≋≡▁▔◉☺]/ containedin=CHATmainline
endif

" dependent tier
syntax match  CHATdepntier     /^%\w\+:/
syntax match  CHATdepntierdata /\%(^%\%(pho\|mod\)\+:\s\+\)\@<=.*/

" other things
syntax match CHATpostcode  /\[[^\]]\+\]/          containedin=CHATmainline
syntax match CHATtimestamp /[·•][0-9_]\+[·•]/ containedin=CHATmainline contains=CHATtsbullet
syntax match CHATtsbullet  /%\w\+:/               containedin=CHATtimestamp
syntax match CHATsep  /|/                         containedin=CHATatheader

" errors
syntax match CHATsyntaxerror        /^[^@*% \t].*/
syntax match CHATsyntaxerror        /\%^\%(@Begin\_$\)\@!\n*.*/
syntax match CHATsyntaxerror        /.*\n*\%(\_^@End\)\@<!\%$/

" header lines erroneously inserted within the data
" this regex is broken: it does not detect header lines after indented lines
syntax match CHATsyntaxerrorheader  /\%(\_^[*%].*\n\%(\_^\s.*\n\)*\)\@<=\_^@.*\%(\n\%(\_^\s.*\n\)*\_^[*%].*\)\@=/


" hidden headers
if b:minchat == 0
	syntax match CHAThiddenheader /^@Font:.*$/
	syntax match CHAThiddenheader /^@UTF8$/
	syntax match CHAThiddenheader /^@PID:.*8$/
	syntax match CHAThiddenheader /^@ColorWords:.*$/
endif

" changeable headers
syntax match CHATchangeableheader /^@Activities:.*$/
syntax match CHATchangeableheader /^@Bck:.*$/
syntax match CHATchangeableheader /^@Bg.*$/
syntax match CHATchangeableheader /^@Blank.*$/
syntax match CHATchangeableheader /^@Comment:.*$/
syntax match CHATchangeableheader /^@Date:.*$/
syntax match CHATchangeableheader /^@Eg.*$/
syntax match CHATchangeableheader /^@G:.*$/
syntax match CHATchangeableheader /^@New Episode.*$/
syntax match CHATchangeableheader /^@New Language:.*$/
syntax match CHATchangeableheader /^@Page:.*$/
syntax match CHATchangeableheader /^@Situation:.*$/


" primitive semantic highlighting of (up to 16) participant id's
" adapted from <https://stackoverflow.com/a/21389025>
if !exists('g:colorParticipants') || g:colorParticipants == 1
	let colors = ["E64527", "8DB02F", "93651D", "DF8123", "6A6E1E", "CE9F2A", "E07759", "C09772", "A1A257", "B13A27", "D26A2C", "CD9A52", "6C8720", "985332", "77633C", "AEAC32"]
	for line in readfile(expand("%:p"))
		let participant = matchstr(line, '@ID:\s\+[^|]*|[^|]*|\zs[^|]\+') " regex match
		if(!empty(participant))
			execute 'syn keyword CHATid_' . participant . ' ' . participant
			execute 'hi default CHATid_' . participant 'guifg=#' . remove(colors, 0) . ' gui=bold'
			execute 'syn cluster CHATparticipants add=CHATid_' . participant
		endif
	endfor
else
	hi def link CHATmainlinetag Statement
endif


" hi def link CHATatheader          String
" hi def link CHATatheadertag       PreProc
hi def link CHATatheader          Comment
hi def link CHATatheadertag       Todo
hi def link CHAThiddenheader      Comment
hi def link CHATchangeableheader  Comment

hi def link CHATmainlinedata      Normal
" hi def link CHATmainlinetag       Statement " dependent on g:colorParticipants
hi def link CHATdepntier          Function
" hi def link CHATdepntierdata      Function
" hi def link CHATdepntier          Normal
" hi def link CHATdepntierdata      Normal
hi def link CHATcommentsdata      Comment
hi def link CHATunintelligible    Debug
hi def link CHATevent             Debug
hi def link CHATinterrupt         Delimiter
hi def link CHATpitchmark         Tag

hi def link CHATpostcode          Constant
hi def link CHATtimestamp         Type
hi def link CHATtsbullet          Tag
hi def link CHATsep               Comment

hi def link CHATsyntaxerror       Error
hi def link CHATsyntaxerrorheader Error

let b:current_syntax = "chat"

