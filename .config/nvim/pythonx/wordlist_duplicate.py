"""Fix duplicate entries in the spellfile.

If executed in the spell directory, one can run::

    python ../pythonx/wordlist_duplicate.py en.utf-8.add

.. warning:: Still a work in progress

    This file also will sort itself rendering it unusable!!! Still needs
    debugging unfortunately.


....Wait. I had sys.argv[:]...that means the file name was used as an argument.
It should ignore itself if we go sys.argv[1:] right?


"""
import logging
from pathlib import Path
import sys

import vim


class Target:
    """Create a class for our target buffer.

    We can just allow other users to change the class attribute
    as necessary.
    """
    _target_file = Path('../spell/en.utf-8.add').resolve()
    target_file = str(_target_file)


def vim_bufnr():
    """No params returns the current bufnr."""
    return vim.current.buffer


def nvim_listen_address():
    return os.environ.get('NVIM_LISTEN_ADDRESS')


def attach_nvim(how='socket', path=None):
    """Ensure you don't execute this from inside neovim or it'll emit an error."""
    from pynvim import attach
    return attach('socket', path=nvim_listen_address())


def vim_api():
    """Tepidly I'm going to use this now."""
    # it worked!
    vim.command("exec 'e ' . stdpath('config') . '/spell/en.utf-8.add'")
    # this doesnt :/
    # vim.command("sort expand('%')")


def fix_spellfile(wordlist):
    """Take the old file and append it piecemeal to a new list.

    This function checks that the old element exists, that the
    word and the next word don't match, and that the item doesn't
    start with an :kbd:`!`. These are words that are considered
    incorrect and can be safely ignored.

    Parameters
    ----------
    wordlist : list
        List of correct words.
    Returns
    -------
    new_wordlist : list
        Filtered list of words.

    """
    new_wordlist = []
    for i, j in enumerate(wordlist):
        try:
            if i > 0:
                if wordlist[i] and wordlist[i] != wordlist[i + 1] \
                        and not wordlist[i].startswith('!'):
                    new_wordlist.append(j)
        except IndexError:  # Goes until its 1 too high idk how to stop that
            break

    return new_wordlist


def sortfile(spellfile):
    """Sort `spellfile` as the implemented fix only works if sorted.

    Parameters
    ----------
    spellfile : str (Path-like)
        File to fix.

    Returns
    -------
    sorted_spellfile : list
        Sorted list of words.

    """
    with open(spellfile, 'rt') as f:
        spellobj = f.readlines()

    sorted_spellfile = sorted(spellobj)
    return sorted_spellfile


def main():
    """Execute the module.

    .. admonition::

        Don't use sys.argv[1:] when executing a file using py3file in neovim!
        Args 1 and 2 are already set to -c and 'script-host.py'

    """
    args = sys.argv[3:]
    if len(args) < 1:
        # don't use sys.exit. Kills the channel between you and the remote host that powers everything.
        # besides you have to manually assign to sys.argv anyway.
        args = [Target().target_file]

    logging.basicConfig(level=logging.DEBUG)

    logging.debug('Args: ', args)
    for i in args[0:]:
        spell_list = sortfile(i)
        # vim_api()
        fixed = fix_spellfile(spell_list)
        with open(i, 'wt') as f:
            f.writelines(fixed)


if __name__ == '__main__':
    main()
