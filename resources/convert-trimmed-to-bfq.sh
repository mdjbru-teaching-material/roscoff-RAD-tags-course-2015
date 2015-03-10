#!/bin/bash
FILES=`ls *.trimmed`

for f in $FILES
do
  echo $f
  maq sol2sanger $f $f.sanger
  maq fastq2bfq $f.sanger $f.bfq
done
