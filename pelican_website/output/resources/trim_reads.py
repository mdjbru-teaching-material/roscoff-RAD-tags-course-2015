### * Description

# Script to trim reads from a FASTQ file. Reads are trimmed from the 3' end
# until the Phred score is >= scoreThreshold. Only reads of length >=
# lengthThreshold are kept.
#
# Usage
# python script.py inputFile scoreThrehsold lengthThreshold

### * Set up

### ** Import

import sys

### ** Parameters

INPUT_FILE = sys.argv[1]
SCORE_THRESHOLD = int(sys.argv[2])
LENGTH_THRESHOLD = int(sys.argv[3])
PHRED_CONSTANT = 64

### * Run

with open(INPUT_FILE, "r") as fi :
    with open(INPUT_FILE + ".trimmed", "w") as fo :
        for l1 in fi :
            l2 = fi.next()
            l3 = fi.next()
            l4 = fi.next()
            phred_score = [ord(x) - PHRED_CONSTANT for x in l4.strip()]
            i = len(phred_score) - 1
            while (i > 0 and phred_score[i] < SCORE_THRESHOLD) :
                i -= 1
            if (i + 1) >= LENGTH_THRESHOLD :
                fo.write(l1)
                fo.write(l2.strip()[0:(i+1)] + "\n")
                fo.write(l3)
                fo.write("".join([chr(x + PHRED_CONSTANT) for x in phred_score[0:(i+1)]]) + "\n")
