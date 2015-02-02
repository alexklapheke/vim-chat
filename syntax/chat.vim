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
syntax region CHATatheader    start=/^@/ end=/^[@*%]\@=/ contains=CHATatheadertag,CHATsep,CHATsyntaxerror
syntax match  CHATatheadertag /^@[^:]\+:\?/              contained

" main transcription data
syntax region CHATmainline     start=/^\*/ end=/^[@*%]\@=/ transparent contains=CHATmainlinetag,CHATpostcode,CHATtimestamp,CHATsyntaxerror,CHATunintelligible,CHATinterrupt,CHATpitchmark
syntax match  CHATmainlinetag  /^\*\w\+:/                  contained
syntax match  CHATcommentsdata /\(^%\w\+:\s\+\)\@<=.*/

syn keyword CHATunintelligible xxx
syn match   CHATunintelligible /\<&\w\+\>/ contained

if exists("b:chat_ca")
	syntax match CHATinterrupt /[⌈⌉⌊⌋]/ contained
	syntax match CHATpitchmark /[§°·āšʔʕʰΫạἩ„‡⁇⁎↑→↓↗↘↻⇗⇘∆∇∞∫∲∾≈≋≡▁▔◉☺]/ contained
endif

" dependent tier
syntax match  CHATdepntier     /^%\w\+:/
syntax match  CHATdepntierdata /\(^%\(pho\|mod\)\+:\s\+\)\@<=.*/

" other things
syntax match CHATpostcode  /\[[^\]]\+\]/          contained
syntax match CHATtimestamp /[·•][0-9_]\+[·•]/ contained contains=CHATtsbullet
syntax match CHATtsbullet  /%\w\+:/               contained
syntax match CHATsep  /|/                         contained

" errors
syntax match CHATsyntaxerror        /^[^@*% \t].*/
syntax match CHATsyntaxerror        /\%^\(@Begin\_$\)\@!\n*.*/
syntax match CHATsyntaxerror        /.*\n*\(\_^@End\)\@<!\%$/

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


hi def link CHATatheader     String
hi def link CHATatheadertag  PreProc
" hi def link CHATatheader     Comment
" hi def link CHATatheadertag  Todo
hi def link CHAThiddenheader Comment

hi def link CHATmainlinetag  Statement
hi def link CHATdepntier     Function
" hi def link CHATdepntierdata Function
" hi def link CHATdepntier     Normal
" hi def link CHATdepntierdata Normal
hi def link CHATcommentsdata   Comment
hi def link CHATunintelligible String
hi def link CHATinterrupt      Delimiter
hi def link CHATpitchmark      Tag

hi def link CHATpostcode     Constant
hi def link CHATtimestamp    Type
hi def link CHATtsbullet     Tag
hi def link CHATsep          Comment

hi def link CHATsyntaxerror  Error
hi def link CHATsyntaxerrorheader  Error

let b:current_syntax = "chat"

