#######################
# Better GDB defaults #
#######################

source ~/.repos/gdb-dashboard/.gdbinit
set verbose off
set print pretty on
set print array off
set print array-indexes on
set history save on
set history size 256
set history remove-duplicates unlimited
set history filename ~/.gdb_history

#######################
# Configure Dashboard #
#######################

dashboard -enabled off

###########################
# Custom Commands (Alias) #
###########################

define addr
    if $argc == 0
        help
    end
    if $argc == 1
        info address $arg0
    end
end
document addr
Print address of argument.
end

# ------------------------------------------------------------------------------

define symbol
    if $argc == 0
        help
    end
    if $argc == 1
        info symbol $arg0
    end
end
document symbol
Print associated symbol of address.
end

# ------------------------------------------------------------------------------

define type
    if $argc == 0
        help
    end
    if $argc == 1
        ptype $arg0
    end
end
document type
Print type of argument.
end

# ------------------------------------------------------------------------------

define argv
    show args
end
document argv
Print program arguments.
end

# ------------------------------------------------------------------------------

define stack
    if $argc == 0
        info stack
    end
    if $argc == 1
        info stack $arg0
    end
    if $argc > 1
        help stack
    end
end
document stack
Print backtrace of the call stack, or innermost COUNT frames.
Usage: stack <COUNT>
end

# ------------------------------------------------------------------------------

define frame
    if $argc == 0
        info frame
    end
    if $argc == 1
        info frame $arg0
    end
    if $argc > 1
        help frame
    end
end
document frame
Print information about frame.
end

# ------------------------------------------------------------------------------

define func
    if $argc == 0
        info functions
    end
    if $argc == 1
        info functions $arg0
    end
    if $argc > 1
        help func
    end
end
document func
Print all function names in target, or those matching REGEXP.
Usage: func <REGEXP>
end

# ------------------------------------------------------------------------------

define var
    if $argc == 0
        info variables
    end
    if $argc == 1
        info variables $arg0
    end
    if $argc > 1
        help var
    end
end
document var
Print all global and static variable names (symbols), or those matching REGEXP.
Usage: var <REGEXP>
end

# ------------------------------------------------------------------------------

define sig
    if $argc == 0
        info signals
    end
    if $argc == 1
        info signals $arg0
    end
    if $argc > 1
        help sig
    end
end
document sig
Print what debugger does when program gets various signals.
Specify a SIGNAL as argument to print info on that signal only.
Usage: sig <SIGNAL>
end

# ------------------------------------------------------------------------------

define threads
    info threads
end
document threads
Print threads in target.
end

# ------------------------------------------------------------------------------

define dis
    if $argc == 0
        disassemble
    end
    if $argc == 1
        disassemble $arg0
    end
    if $argc == 2
        disassemble $arg0 $arg1
    end 
    if $argc > 2
        help dis
    end
end
document dis
Disassemble a specified section of memory.
Default is to disassemble the function surrounding the PC (program counter)
of selected frame. With one argument, ADDR1, the function surrounding this
address is dumped. Two arguments are taken as a range of memory to dump.
Usage: dis <ADDR1> <ADDR2>
end

# Start ------------------------------------------------------------------------

python Dashboard.start()

# File variables ---------------------------------------------------------------

# vim: filetype=python
# Local Variables:
# mode: python
# End:
