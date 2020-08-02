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

# ------------------------------------------------------------------------------

define reg
    if $argc == 0
        info register
    end
    if $argc == 1
        info register $arg0
    end
    if $argc > 1
        help reg
    end
end
document reg
Show register dump.
Usage: dis <REG>
end

# ------------------------------------------------------------------------------

define octodebug
    handle SIG49 nostop noprint
    handle SIG44 nostop noprint
    handle SIG46 nostop noprint
    handle SIG35 nostop noprint
end
document octodebug
Use config used for invasIC (x86guest).
Usage: octodebug
end

# ------------------------------------------------------------------------------

define frontend
    dashboard -layout source
    dashboard -enabled on
end
document front
Start dasboard frontend.
Usage: frontend
end

# ------------------------------------------------------------------------------

define gva2gpa
    if $argc == 1
        eval "monitor gva2gpa %p" $arg0
    end
    if $argc != 1
        help gva2gpa
    end
end
document gva2gpa
Get physical address for given virtual address (QEMU only).
Usage: gva2gpa addr
end

# ------------------------------------------------------------------------------

define xp
    if $argc == 0
        help xp
    end

    if $argc == 1
        eval "monitor xp %p", $arg0
    end

    if $argc == 2
        eval "monitor xp $arg0 %p", $arg1
    end
end
document xp
Examine memory of associated physical address (QEMU only).
Usage: xp /fmt addr
end

###########################
# Custom Python Functions #
###########################

python
class CustomCommands(gdb.Command):
    """Show custom commands."""

    def __init__(self):
        super(CustomCommands, self).__init__("custom", gdb.COMMAND_USER)

    def invoke (self, args, from_tty):
        print("addr      - Print address of argument")
        print("symbol    - Print symbol for argument")
        print("type      - Print type of argument")
        print("argv      - Print program arguments")
        print("stack     - Print backtrace")
        print("func      - Print function matching argument (regex)")
        print("var       - Print global variables matching argument")
        print("threads   - Print threads")
        print("dis       - Disassemble memory section")
        print("reg       - Print registers")
        print("octodebug - Setup for InvasIC")
        print("gva2gpa   - Print physical address for given virual address (QEMU only)")
        print("xp        - Examine physical memory")
        print("fronted   - Start Dashboard frontend")
        print("split     - Create split for Dashboard")
        print("height    - Set height of split in Dashboard")
        print("hexdump   - Show hexdump")

CustomCommands()
end

# ------------------------------------------------------------------------------

python

class DashboardSplit(gdb.Command):
    """Create split for Dashboard."""

    def __init__(self):
        super(DashboardSplit, self).__init__("split", gdb.COMMAND_USER)

    def invoke (self, args, from_tty):
        argv = gdb.string_to_argv(args)

        # Check length of arguments
        if len(argv) == 0:
            raise gdb.GdbError("Usage: split [source | assembly | registers | variables]")

        # Check valid arguments
        for arg in argv:
            if not arg in ["source", "assembly", "registers", "variables"]:
                raise gdb.GdbError("Usage: split [source | assembly | registers | variables]")

        # Split
        gdb.execute("dashboard -layout {}".format(" ".join(argv)))
        return

DashboardSplit()
end

# ------------------------------------------------------------------------------

python

class DashboardHeight(gdb.Command):
    """Set height of Dashbaord-Split"""

    def __init__(self):
        super(DashboardHeight, self).__init__("height", gdb.COMMAND_USER)

    def invoke (self, args, from_tty):
        argv = gdb.string_to_argv(args)

        # Check length of arguments
        if len(argv) < 2:
            raise gdb.GdbError("Usage: height [source | assembly | registers | variables] VAL")

        height = argv[-1]
        del argv[-1]

        # Check valid arguments
        for arg in argv:
            if not arg in ["source", "assembly", "registers", "variables"]:
                raise gdb.GdbError("Usage: height [source | assembly | registers | variables] VAL")

        # Set height
        for arg in argv:
            gdb.execute("dashboard {} -style height {}".format(arg, height))
        return

DashboardHeight()
end

# ------------------------------------------------------------------------------

python
import sys
import binascii
class HexDump(gdb.Command):
    """HexDump memory.
Show HexDump of given address. If no LEN is provided, hexdump will use the
default length of 32 bytes. Internally, hexdump will round ADDR and LEN to the
next multiple of 8."""

    def __init__(self):
        super(HexDump, self).__init__("hexdump", gdb.COMMAND_USER)

    def read_memory(self, addr, length):
        return gdb.selected_inferior().read_memory(addr, length).tobytes()

    def invoke (self, args, from_tty):
        argv = gdb.string_to_argv(args)

        # Check length of arguments
        if len(argv) == 0 or len(argv) > 3:
            raise gdb.GdbError("Usage: dp ADDR [LEN]")

        # Parse Parameter
        addr = gdb.parse_and_eval(argv[0])
        length = 32
        if len(argv) >= 2:
                length = gdb.parse_and_eval(argv[1])

        # Align addr, length to 8 Byte boundry
        length = length + (addr % 8)
        if length % 8 != 0:
            length = length + (8 - length % 8)
        addr = addr - (addr % 8)

        # Read memory
        mem = self.read_memory(addr, length)

        # Print memory
        for i in range(0, length, 8):
            sys.stdout.write("0x{:016x} ".format(int(addr)))
            addr = addr + 8

            for j in range(0, 8):
                sys.stdout.write("{:02x} ".format(int(mem[i + j])))

            sys.stdout.write("| ")

            for j in range(0, 8):
                character = mem[i + j]
                if character >= 32 and character <= 127:
                    sys.stdout.write("{} ".format(chr(character)))
                else:
                    sys.stdout.write(". ")

            sys.stdout.write("\n")

        sys.stdout.flush()

HexDump()
end
