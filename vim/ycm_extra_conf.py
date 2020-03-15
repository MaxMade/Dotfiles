import os
import subprocess

def Settings( **kwargs ):
    baseFlags = [ '-Wall', '-Wextra', '-Werror' ]

    file = os.getcwd()
    paths = subprocess.check_output("find " + file + " -maxdepth 10 -iname '*.h'", shell=True).splitlines()
    paths = [os.path.dirname(line.decode("utf-8")) for line in paths]

    for path in paths:
        baseFlags.append('-I')
        baseFlags.append(path)

    return {
        'flags': baseFlags,
    }
