" Vim syntax file
" Language: CHAT transcription format
" Maintainer: Alex Klapheke <alexklapheke@gmail.com>
" License: GPL v2
" Updated: 26 Oct 2015
" TODO: Implement matchparen-style highlighting for CHATinterrupt brackets

" Don't supersede an already-loaded syntax file
if exists("b:current_syntax")
	finish
endif

syntax case match

" tier identifiers
syntax match  CHATatheadertag /^@[^:]\+:\?/ containedin=CHATatheader
syntax match  CHATmainlinetag /^\*\w\+:/    containedin=CHATmainline contains=@CHATparticipants
syntax match  CHATdepntiertag /^%\w\+:/     containedin=CHATdepntier

" the rest of the data on the tier
syntax match  CHATmainlinedata /\%(^\*\w\+:\|^\s\+\)\@<=.*/ containedin=CHATmainline
syntax match  CHATdepntierdata /\%(^%\w\+:\|^\s\+\)\@<=.*/  containedin=CHATdepntier

" encapsulations of multiline tiers
syntax region CHATatheader start=/^@/  end=/^[*%]\@=/              keepend contains=CHATatheadertag,CHATsep,CHATsyntaxerror,@CHATparticipants
syntax region CHATmainline start=/^\*/ end=/^[*%@]\@=/ transparent keepend contains=CHATmainlinetag,CHATmainlinedataCHATpostcode,CHATtimestamp,CHATsyntaxerror,CHATunintelligible,CHATinterrupt,CHATpitchmark
syntax region CHATdepntier start=/^%/  end=/^[*%@]\@=/ transparent keepend contains=CHATdepntiertag,CHATdepntierdata

" various transcript markings
syntax keyword CHATunintelligible xxx                      containedin=CHATmainlinedata
syntax match CHATunintelligible /&\w\+/                    containedin=CHATmainlinedata
syntax match CHATevent          /&=[A-Za-z0-9_:]\+/        containedin=CHATmainlinedata
syntax match CHATevent          /&[{}]\(\a\)=\w\+/         containedin=CHATmainlinedata
syntax match CHATpause          /(\.\+)/                   containedin=CHATmainlinedata
syntax match CHATpostcode       /\[[^\]]\+\]/              containedin=CHATmainlinedata
syntax match CHATlinecomment    /\[%[^\]]\+\]/             containedin=CHATmainlinedata
syntax match CHATtimestamp      /[·•][0-9_]\+[·•]/ containedin=CHATmainlinedata

if exists("b:chat_ca")
	syntax match CHATinterrupt /[⌈⌉⌊⌋]/                                 containedin=CHATmainlinedata
	syntax match CHATpitchmark /[§°·āšʔʕʰΫạἩ„‡⁇⁎↑→↓↗↘↻⇗⇘∆∇∞∫∲∾≈≋≡▁▔◉☺]/ containedin=CHATmainlinedata
endif

" header separator
syntax match CHATsep /|/ containedin=CHATatheader

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

" changeable headers (allowable within data; must supersede CHATsyntaxerrorheader)
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


" Primitive semantic highlighting of participant IDs
" adapted from <https://stackoverflow.com/a/21389025>
if !exists('g:colorParticipants') || g:colorParticipants == 1
	let s:i = 0
	let s:colors = ["E64527", "8DB02F", "93651D", "DF8123", "6A6E1E", "CE9F2A", "E07759", "C09772", "A1A257", "B13A27", "D26A2C", "CD9A52", "6C8720", "985332", "77633C", "AEAC32"]
	for s:line in readfile(expand("%:p"))
		let s:participant = matchstr(s:line, '@ID:\s\+[^|]*|[^|]*|\zs[^|]\+')
		if(!empty(s:participant))
			execute 'syn keyword CHATid_' . s:participant . ' ' . s:participant
			execute 'syn cluster CHATparticipants add=CHATid_' . s:participant
			execute 'hi default CHATid_' . s:participant . ' ctermfg=' . string(s:i%len(s:colors)) . ' guifg=#' . s:colors[s:i%len(s:colors)] . ' cterm=bold gui=bold'
			let s:i += 1
		endif
	endfor
else
	" if semantic highlighting off, we still want these to be colored
	hi def link CHATmainlinetag Statement
endif


" headers
hi def link CHATatheader          Comment
hi def link CHATatheadertag       Todo
hi def link CHAThiddenheader      Comment
hi def link CHATchangeableheader  Comment
hi def link CHATsep               Comment

" dependent tiers
hi def link CHATdepntiertag       Comment
hi def link CHATdepntierdata      Comment
hi def link CHATlinecomment       Comment

" main tiers
hi def link CHATunintelligible    Debug
hi def link CHATevent             Debug
hi def link CHATinterrupt         Delimiter
hi def link CHATpitchmark         Tag
hi def link CHATpostcode          Constant
hi def link CHATtimestamp         Type

" errors
hi def link CHATsyntaxerrorheader Error
hi def link CHATsyntaxerror       Error

let b:current_syntax = "chat"

