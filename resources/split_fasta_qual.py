###* Description

# Script to split a FASTQ file into a fasta file and a quality file,
# for use by CAP3
#
# NOTE: The conversion from FASTQ to QUAL file is not certain
# DO NOT USE THIS SCRIPT FOR A REAL ANALYSIS!
#
# Usage:
# python script.py inputFile

### * Setup

### ** Import

import sys

### ** Parameters

INPUT_FILE = sys.argv[1]
PHRED_CONSTANT = 64

### * Function

### ** convertPhredToQual(phred)

def convertPhredToQual(phred) :
    o = ""
    for c in phred.strip() :
        o += str(ord(c) - PHRED_CONSTANT) + " "
    o = o.strip()
    return(o)

### * Run

with open(INPUT_FILE, "r") as fi :
    with open(INPUT_FILE + ".fasta", "w") as fo_fasta :
        with open(INPUT_FILE + ".fasta.qual", "w") as fo_qual :
            for l in fi :
                fo_fasta.write(">" + l[1:])
                fo_fasta.write(fi.next())
                fo_qual.write(">" + fi.next()[1:])
                fo_qual.write(convertPhredToQual(fi.next()) + "\n")
