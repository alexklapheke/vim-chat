" Vim syntax file
" Language:	CHAT transcription format
" Maintainer: Alex Klapheke <alexklapheke@gmail.com>
" License: GPL v2

" Don't supersede an already-loaded syntax file
" if exists("b:current_syntax")
" 	finish
" endif

syntax case match
setlocal tabstop=16

" metadata at top of file
syntax region CHATatheader    start=/^@/ end=/^[@*%]\@=/ contains=CHATatheadertag,CHATsep,CHATsyntaxerror
syntax match  CHATatheadertag /^@[^:]\+:\?/              contained

" main transcription data
syntax region CHATmainline     start=/^\*/ end=/^[@*%]\@=/ transparent contains=CHATmainlinetag,CHATpostcode,CHATtimestam,CHATsyntaxerror
syntax match  CHATmainlinetag  /^\*\w\+:/                  contained
syntax match  CHATcommentsdata /\(^%\w\+:\s\+\)\@<=.*/

" dependent tier
syntax match  CHATdepntier     /^%\w\+:/
syntax match  CHATdepntierdata /\(^%\(pho\|mod\)\+:\s\+\)\@<=.*/

" other things
syntax match CHATpostcode /\[[^\]]\+\]/          contained
syntax match CHATtimestam /[·•][0-9_]\+[·•]/ contained contains=CHATtsbullet
syntax match CHATtsbullet /%\w\+:/               contained
syntax match CHATsep /|/                         contained

" errors
syntax match CHATsyntaxerror  /^[^@*% \t].*/
syntax match CHATsyntaxerror  /\%^\(@Begin\_$\)\@!\n*.*/
syntax match CHATsyntaxerror  /.*\n*\(\_^@End\)\@<!\%$/


hi def link CHATatheader     String
hi def link CHATatheadertag  PreProc
" hi def link CHATatheader     Comment
" hi def link CHATatheadertag  Todo

hi def link CHATmainlinetag  Statement
hi def link CHATdepntier     Function
" hi def link CHATdepntierdata Function
" hi def link CHATdepntier     Normal
" hi def link CHATdepntierdata Normal
hi def link CHATcommentsdata Comment

hi def link CHATpostcode     Constant
hi def link CHATtimestam     Type
hi def link CHATtsbullet     Tag
hi def link CHATsep          Comment

hi def link CHATsyntaxerror  Error

" let b:current_syntax = "chat"

