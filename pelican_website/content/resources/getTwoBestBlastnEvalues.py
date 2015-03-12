#! /usr/bin/python

# ------------------------------------------------------- #
# select blast results forge - getConsistentBlastxResults #
# ------------------------------------------------------- #

"""The results from a blastn result file are analysed to produce a table with the best last
best e-value entry for each contig, and the value of the second best e-value (it can be the
same if several hits had the same e-values).

"""

# Usage
# python script.py inputFile outputFile

### * Import

import sys
import math

### * Parameters

INPUT_FILE = sys.argv[1]
OUTPUT_FILE = sys.argv[2]
KEYS = ["qseqid", "sseqid", "qstart", "qend", "sstart", "send", "qseq", "sseq",
  "evalue", "bitscore", "score", "length", "pident", "nident", "mismatch", "positive",
  "gapopen", "gaps", "qframe", "sframe"]

### * Functions

### ** parseTableToDict

def parseTableToDict(filePath, keys = True, separator = "\t",
  skipEmpty = True, returnEmptyOnFileException = False) :
        
    """
    
    Takes
    filePath : a path to a file
    keys (True) : a list of keys to be used for the dictionaries
     If set to True, the first line of the file is used as headers
    separator ("\t") : the string used as column separator
    skipEmpty (True) : if True, do not return empty lines in the file 
    
    Returns
    an iterator over the lines of the file, producing a dictionary 
      per line (non-empty lines only if skipEmpty = True)
    
    """
    fileHandler = open(filePath, "r")
    if (keys == True) :
        keys = fileHandler.readline().rstrip(" \r\n").split(separator)
    for line in fileHandler :
        if (skipEmpty) :
            if (line.rstrip() != "") :
                yield(dict(zip(keys, line.rstrip().split(separator))))
        else :
            yield(dict(zip(keys, line.rstrip().split(separator))))
    fileHandler.close()

### * Run

# open the input file and create the iterator
inputFileIterator = parseTableToDict(INPUT_FILE, keys = KEYS)

# create a dictionary to store the results
output = {}

# go through the results and keep the best e-value entry and the second best e-value
noResult = 0
for result in inputFileIterator :
    previousEntry = output.get(result["qseqid"], ["NA", "NA", {}])
    if (previousEntry[0] == "NA" or float(result["evalue"]) <= previousEntry[0]) :
        previousEntry[1] = previousEntry[0]
        previousEntry[0] = float(result["evalue"])
        previousEntry[2] = result
    elif (previousEntry[1] == "NA" or float(result["evalue"]) <= previousEntry[1]) :
        previousEntry[1] = float(result["evalue"])
    output[result["qseqid"]] = previousEntry    
    if (noResult % 100000 == 0) :
        print "Result " + str(noResult) + ", unique seq found : " + str(len(output))
    noResult += 1

# convert the e-value to log
noEntry = 0
for seqId in output :
    bestEvalLog = math.log10(output[seqId][0])
    try :
        secondLog = math.log10(output[seqId][1])
        deltaLog = secondLog - bestEvalLog
    except :
        secondLog = "NA"
        deltaLog = "NA"
    output[seqId] = [bestEvalLog, secondLog, deltaLog, output[seqId][2]]
    noEntry += 1
    if (noEntry % 10000 == 0) :
        print str(noEntry) + " entries converted to log"
        
# write the output file

outputFileHandle = open(OUTPUT_FILE, "w")
headers = ["log10BestEvalue", "log10SecondEvalue", "deltaLogBestEvalues"] + KEYS + ["flag"]
headers = ["blastn" + x for x in headers]
headers = ["contig"] + headers 
outputFileHandle.write("\t".join(headers) + "\n")
for eachEntry in output :
    elements = [eachEntry, output[eachEntry][0], output[eachEntry][1], output[eachEntry][2]]
    for key in KEYS :
        elements.append(output[eachEntry][3][key])
    elements = [str(x) for x in elements] + ["best_blastn_from_two_best_evalues_selection_and_filtering"]
    outputFileHandle.write("\t".join(elements) + "\n")
outputFileHandle.close()

print "Got best e-values !"
