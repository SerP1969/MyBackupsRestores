#!/usr/bin/bash
. ~oracle/bin/racenv +asm
asmcmd << __EOF__
lsdg
exit
__EOF__
