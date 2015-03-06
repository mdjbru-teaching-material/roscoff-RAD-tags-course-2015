### * Description

# Script to generate noise in short reads by randomly changing some of the
# first base pairs in the sequences.
#
# The script take a fastq file as input, and only modifies the sequence itself,
# not the quality score. It is not robust at all and assumes no blank lines,
# and four lines per read.
#
# Usage:
# script.py inputFile nFirstBases probToChange


### * Setup

### ** Import

import sys
import random

### ** Parameters

# From command line
INPUT_FILE = sys.argv[1]
N_FIRST_BASES = int(sys.argv[2])
PROB_TO_CHANGE = float(sys.argv[3])

# Built-in
ALT = ["A", "T", "G", "C", ""]

### * Functions

### ** add_noise(seq, n, p)

def add_noise(seq, n, p) :
    for i in range(n) :
        if random.random() <= p :
            seq = list(seq)
            seq[i] = random.choice(ALT)
            seq = "".join(seq)
    return(seq)

### * Run

with open(INPUT_FILE, "r") as fi :
    with open(INPUT_FILE + ".noise", "w") as fo :
        for l in fi :
            fo.write(l)
            seq = fi.next()
            seq = add_noise(seq, N_FIRST_BASES, PROB_TO_CHANGE)
            fo.write(seq)
            fo.write(fi.next())
            fo.write(fi.next())

    
