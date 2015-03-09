### * Description

# Script to get read length from a fasta file (sequences can be multi-liners).
#
# Usage:
# python script.py inputFile

### * Setup

### ** Import

import sys
from Bio import SeqIO

### ** Parameters

INPUT_FILE = sys.argv[1]

### * Run

with open(INPUT_FILE, "r") as fi :
    with open(INPUT_FILE + ".lengths", "w") as fo :
        h = SeqIO.parse(fi, "fasta")
        for s in h :
            fo.write(str(len(str(s.seq))) + "\n")

