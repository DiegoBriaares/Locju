import os
import sys

to_combine = sys.stdin.read()

BASEDIR = "C:\\Locju\\utilities\\validator\\combine_files\\"

f = open(os.path.join(BASEDIR, 'combined'), "a")
f.write(to_combine)
f.write("\n")
f.close()