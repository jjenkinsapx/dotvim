fun! MySys()
   return "linux"
endfun
set runtimepath=~/.vimruntime,~/.vimruntime/after,$VIMRUNTIME
source ~/.vimruntime/vimrc
helptags ~/.vimruntime/doc

call pathogen#infect()
