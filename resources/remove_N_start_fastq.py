### * Description

# Script to remove the N first nucleotide positions in a FASTQ file.
#
# The script assumes that there are no blank lines in the input files,
# and that each record has four lines. It will remove N characters
# from the second and fourth lines of each record.
#
# Usage:
# python script.py inputFile1 [inputFile2 ...] N_positions

### * Setup

### ** Import

import sys

### ** Parameters

N_ARGS = len(sys.argv) - 1
INPUT_FILES = sys.argv[1: N_ARGS]
N_TO_REMOVE = int(sys.argv[N_ARGS])

### * Run

for INPUT_FILE in INPUT_FILES :
    print("Removing %i nucleotides in: %s" % (N_TO_REMOVE, INPUT_FILE))
    with open(INPUT_FILE, "r") as fi :
        with open(INPUT_FILE + ".clean", "w") as fo :
            for l in fi :
                fo.write(l)
                fo.write(fi.next()[N_TO_REMOVE:])
                fo.write(fi.next())
                fo.write(fi.next()[N_TO_REMOVE:])
