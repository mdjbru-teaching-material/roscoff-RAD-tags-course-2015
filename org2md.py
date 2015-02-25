### * Description

# Simple script to convert org file to markdown for pelican pages. Similar
# things could be done with pandoc probably, but I am not getting the metadata
# exported properly with pandoc. This is intented as a quick and dirty solution
# only.
#
# Basically, the metadata is put away, the org file is converted to markdown by
# pandoc, and then the metadata is added again. Every line starting with "#+"
# is considered as metadata and transferred back into the output file in the
# header, with the "#+" removed.

### * Import

import sys
import os
import subprocess

### * Functions

### ** stripMetadata

def stripMetadata(inputFile, strippedFile) :
    """
    Open inputFile, read it, write its content without metadata to
    strippedFile and return the metadata.
    """
    metadata = ""
    with open(inputFile, "r") as fi :
        with open(strippedFile, "w") as fo:
            for l in fi :
                if (l.startswith("#+")) :
                    metadata += l[2:]
                else :
                    fo.write(l)
    return(metadata)

### ** pandocConvert(inputFile, outputFile)

def pandocConvert(inputFile, outputFile) :
    c = ["pandoc", "-f", "org",
         "-t", "markdown", inputFile, "-o", outputFile]
    p = subprocess.Popen(c)
    return(p.wait())

### ** addMetadata(inputFile, metadata, outputFile)

def addMetadata(inputFile, metadata, outputFile):
    with open(inputFile, "r") as fi :
        with open(outputFile, "w") as fo :
            fo.write(metadata + "\n")
            for l in fi :
                fo.write(l)
    
### * Run

for inputFile in sys.argv[1:] :
    if (inputFile.endswith(".org")) :
        outputFile = inputFile[:-3] + "md"
    else :
        outputFile = inputFile + ".md"
    print("Convert from org to markdown: %s -> %s" % (inputFile, outputFile))
    metadata = stripMetadata(inputFile, inputFile + ".no-metadata")
    pandocConvert(inputFile + ".no-metadata", outputFile + ".no-metadata")
    addMetadata(outputFile + ".no-metadata", metadata, outputFile)
    os.remove(inputFile + ".no-metadata")
    os.remove(outputFile + ".no-metadata")
