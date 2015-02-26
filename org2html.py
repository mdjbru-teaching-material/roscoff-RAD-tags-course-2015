### * Description

# Simple script to convert org file to html for pelican readers.
#
# Basically, the metadata is put away, the org file is exported to html by
# emacs, and then the metadata is added again. Every line starting with "#+"
# is considered as metadata and transferred back into the output file in the
# header, as meta tags.

### * Import

import sys
import os
import subprocess
import codecs
from bs4 import BeautifulSoup

### * Parameters

META_NOT_EXPORTED = ["OPTIONS"]

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
                    if not any([l[2:].strip().startswith(x) for x in META_NOT_EXPORTED]) :
                        metadata += l[2:]
                else :
                    fo.write(l)
    return(metadata)

### ** emacsConvert(inputFile)

def emacsConvert(inputFile) :
    c = ["emacs", inputFile, "--batch", "-l", "~/.emacs", "-f",
         "org-html-export-to-html", "--kill"]
    p = subprocess.Popen(c)
    return(p.wait())

### ** getHtmlBody(inputFile)

def getHtmlBody(inputFile) :
    with open(inputFile, "r") as fi :
        content = BeautifulSoup(fi.read())
        b = content.body
        b.h1.decompose()
        o = unicode(b)
        o = o.replace("<body>\n<div id=\"content\">", "<body>\n")
        o = o.replace("</div>\n</body>", "</body>")
        return(o)

### ** formatMetaTags(metadata)

def formatMetaTags(metadata) :
    o = ""
    tags = metadata.strip().split("\n")
    for t in tags:
        assert len(t.split(":")) == 2
        n, c = t.split(":")
        n = n.strip()
        c = c.strip()
        o += "<meta name=\"" + n + "\" content=\"" + c + "\" />\n"
    return(o)

### ** formatHtmlPage(metadata, body)

def formatHtmlPage(metadata, body) :
    o = ""
    o += "<html>\n"
    o += "<head>\n"
    o += formatMetaTags(metadata)
    o += "</head>\n"
    o += body
    o += "</html>\n"
    return(o)

### * Run

for inputFile in sys.argv[1:] :
    if (inputFile.endswith(".org")) :
        outputFile = inputFile[:-3] + "html"
    else :
        outputFile = inputFile + ".html"
    print("Convert from org to html: %s -> %s" % (inputFile, outputFile))
    metadata = stripMetadata(inputFile, inputFile + ".no-metadata.org")
    emacsConvert(inputFile)
    body = getHtmlBody(outputFile)
    p = formatHtmlPage(metadata, body)
    with codecs.open(outputFile, encoding = "utf-8", mode = "w") as fo :
        fo.write(unicode(p))
    os.remove(inputFile + ".no-metadata.org")
