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
        else:
            path = target + "/." + f
            print(path)
            #os.remove(path)
            os.symlink(cwd + "/" + f, path)
    except OSError:
        print("Failed: " + f)
