#!/bin/env python3

import os
import sys
import pathlib
import argparse

# Use $HOME
home: str = str(pathlib.Path.home())

# Get CWD
cwd: str = os.getcwd()

# Translation filename -> config path
dotfiles: dict[str, str] = dict()
dotfiles['calcrc'] = home + '/.calcrc'
dotfiles['gdbinit'] = home + '/.gdbinit'
dotfiles['inputrc'] = home + '/.inputrc'
dotfiles['tigrc'] = home + '/.tigrc'
dotfiles['tmux.conf'] = home + '/.tmux.conf'
dotfiles['init.lua'] = home + '/.config/nvim/init.lua'
dotfiles['zshrc'] = home + '/.zshrc'


def main() -> int:
    # Parse arguments
    parser = argparse.ArgumentParser(description='Create symbolic links to dotfiles')
    parser.add_argument('--dry-run', help='show what would be done, without making any changes', action='store_true')
    args = parser.parse_args()
    dry_run: bool = vars(args)['dry_run']

    # Remove all existing config
    print("Removing:")
    for config in dotfiles.values():
        try:
            print(f"    {config}")
            if not dry_run:
                os.remove(config)
        except FileNotFoundError:
            pass
    print("")

    # Create directories (if necessary)
    print("Creating:")
    for path in set([os.path.dirname(i) for i in dotfiles.values()]):
        print(f"    {path}")
        if not dry_run:
            os.makedirs(path, exist_ok=True)
    print("")

    # Create symbolic names
    print("Creating symlinks:")
    for filename, config in zip(dotfiles.keys(), dotfiles.values()):
        filename = cwd + "/" + filename
        print(f"    {filename} -> {config}")
        if not dry_run:
            os.symlink(filename, config)

    return 0


if __name__ == "__main__":
    sys.exit(main())
