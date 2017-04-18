# vim-chat

This is a vim syntax file for the [CHAT transcription format](http://talkbank.org/manuals/CHAT.pdf), which is used in many spoken language corpora, such as [CHILDES](http://childes.psy.cmu.edu/), [TalkBank](http://talkbank.org/), and [SBCSAE](http://www.linguistics.ucsb.edu/research/santa-barbara-corpus).

This is very much a work in progress, as I slowly work my way through the [spec](http://talkbank.org/manuals/CHAT.pdf) and through corpus data.

## Features

Vim-chat features semantic highlighting of participants: each participant gets a unique color, up to 16. The following colors are built in, and work well with the handful of color schemes I've tested.

![](http://i.imgur.com/D0V6PN4.png)

## Installation

### Pathogen

Just `git clone git://github.com/klapheke/vim-chat.git ~/.vim/bundle/vim-chat/`

### Vundle

Add the following to your .vimrc:

```viml
" CHAT transcription syntax
Plugin 'klapheke/vim-chat'
```

## References

MacWhinney, B. (2000). *The CHILDES Project: Tools for Analyzing Talk*. 3<sup>rd</sup> Edition. Mahwah, NJ: Lawrence Erlbaum Associates


