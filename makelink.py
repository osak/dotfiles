#!/usr/bin/python

import glob
import os
import sys
import re

target = sys.argv[1]
cwd = os.getcwd()
ignore = ["README.rst", "makelink.py"]

for f in glob.iglob("*"):
    try:
        if f in ignore:
            pass
        elif re.match(".*~$", f):
            # Ignore vim backup files
            pass
        elif re.match("vimp-plugin", f):
            os.symlink(cwd + "/" + f, target + "/.vimperator/plugin")
        elif re.match("XDG_CONFIG_HOME", f):
            home = os.getenv("HOME")
            config_home = os.getenv("XDG_CONFIG_HOME", home + "/.config")
            for f2 in glob.iglob("*", root_dir = cwd + "/" + f):
                os.symlink(cwd + "/" + f + "/" + f2, config_home + "/" + f2)
        else:
            path = target + "/." + f
            print(path)
            #os.remove(path)
            os.symlink(cwd + "/" + f, path)
    except OSError:
        print("Failed: " + f)
