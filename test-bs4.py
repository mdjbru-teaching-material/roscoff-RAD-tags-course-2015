from bs4 import BeautifulSoup

inputFile = "bibliography-notes.html"

with open(inputFile, "r") as fi :
    soup = BeautifulSoup(fi)
