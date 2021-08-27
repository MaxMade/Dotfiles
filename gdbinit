#######################
# Better GDB defaults #
#######################

set verbose off
set print pretty on
set print array off
set print array-indexes on
set history save on
set history size 256
set history remove-duplicates unlimited
set history filename ~/.gdb_history

##############
# Auto Loads #
##############

add-auto-load-safe-path /usr/lib/go/src/runtime/runtime-gdb.py

#################
# gdb-dashboard #
#################

source /usr/share/gdb-dashboard/.gdbinit
dashboard -layout source assembly variables
