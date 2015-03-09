### * Description

# Script to extract the Phred profiles from FASTQ files
#
# Usage
# python script.py inputFile

### * Set up

### ** Import

import sys

### ** Parameters

INPUT_FILE = sys.argv[1]
PHRED_CONSTANT = 33
PAD_LENGTH = 80

### * Run

with open(INPUT_FILE, "r") as fi :
    with open(INPUT_FILE + ".phred-profiles", "w") as fo :
        for l in fi :
            fi.next()
            fi.next()
            p = fi.next()
            o = [str(ord(x) - 33) for x in p.strip()]
            o += (PAD_LENGTH - len(o)) * ["NA"]
            o = "\t".join(o) + "\n"
            fo.write(o)
            
            
