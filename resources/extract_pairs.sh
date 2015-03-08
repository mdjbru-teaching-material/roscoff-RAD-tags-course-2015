# BYN

echo "Processing BYN"
# Get the list of reverse names for BYN                                                                                    
grep -B 1 -A 2 "^CACTCC" s_1_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > BYN.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f BYN.rev.names s_1_1_sequence.fastq | grep -v "^\-\-" > BYN.pair.for.fastq
# Extract the names of those forward reads
grep "^@" BYN.pair.for.fastq | sed -e "s/\/1//g" > BYN.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f BYN.pair.for.names s_1_2_sequence.fastq | grep -v "^\-\-" > BYN.pair.rev.fastq
rm BYN.*.names

# RYT

echo "Processing RYT"
# Get the list of reverse names for RYT                                                                                    
grep -B 1 -A 2 "^CTTTCC" s_1_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > RYT.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f RYT.rev.names s_1_1_sequence.fastq | grep -v "^\-\-" > RYT.pair.for.fastq
# Extract the names of those forward reads
grep "^@" RYT.pair.for.fastq | sed -e "s/\/1//g" > RYT.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f RYT.pair.for.names s_1_2_sequence.fastq | grep -v "^\-\-" > RYT.pair.rev.fastq
rm RYT.*.names

# HKI

echo "Processing HKI"
# Get the list of reverse names for HKI                                                                                    
grep -B 1 -A 2 "^TCTTCC" s_2_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > HKI.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f HKI.rev.names s_2_1_sequence.fastq | grep -v "^\-\-" > HKI.pair.for.fastq
# Extract the names of those forward reads
grep "^@" HKI.pair.for.fastq | sed -e "s/\/1//g" > HKI.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f HKI.pair.for.names s_2_2_sequence.fastq | grep -v "^\-\-" > HKI.pair.rev.fastq
rm HKI.*.names

# PYO

echo "Processing PYO"
# Get the list of reverse names for PYO
grep -B 1 -A 2 "^CTTTCC" s_3_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > PYO.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f PYO.rev.names s_3_1_sequence.fastq | grep -v "^\-\-" > PYO.pair.for.fastq
# Extract the names of those forward reads
grep "^@" PYO.pair.for.fastq | sed -e "s/\/1//g" > PYO.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f PYO.pair.for.names s_3_2_sequence.fastq | grep -v "^\-\-" > PYO.pair.rev.fastq
rm PYO.*.names

# ABB

echo "Processing ABB"
# Get the list of reverse names for ABB                                                                                    
grep -B 1 -A 2 "^TTGTCC" s_3_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > ABB.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f ABB.rev.names s_3_1_sequence.fastq | grep -v "^\-\-" > ABB.pair.for.fastq
# Extract the names of those forward reads
grep "^@" ABB.pair.for.fastq | sed -e "s/\/1//g" > ABB.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f ABB.pair.for.names s_3_2_sequence.fastq | grep -v "^\-\-" > ABB.pair.rev.fastq
rm ABB.*.names

# SKA

echo "Processing SKA"
# Get the list of reverse names for SKA                                                                                    
grep -B 1 -A 2 "^CACTCC" s_5_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > SKA.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f SKA.rev.names s_5_1_sequence.fastq | grep -v "^\-\-" > SKA.pair.for.fastq
# Extract the names of those forward reads
grep "^@" SKA.pair.for.fastq | sed -e "s/\/1//g" > SKA.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f SKA.pair.for.names s_5_2_sequence.fastq | grep -v "^\-\-" > SKA.pair.rev.fastq
rm SKA.*.names

# LEV

echo "Processing LEV"
# Get the list of reverse names for LEV                                                                                    
grep -B 1 -A 2 "^TCTTCC" s_5_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > LEV.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f LEV.rev.names s_5_1_sequence.fastq | grep -v "^\-\-" > LEV.pair.for.fastq
# Extract the names of those forward reads
grep "^@" LEV.pair.for.fastq | sed -e "s/\/1//g" > LEV.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f LEV.pair.for.names s_5_2_sequence.fastq | grep -v "^\-\-" > LEV.pair.rev.fastq
rm LEV.*.names

# POR

echo "Processing POR"
# Get the list of reverse names for POR                                                                                    
grep -B 1 -A 2 "^TTGTCC" s_6_2_sequence.fastq | grep "^@" | sed -e "s/\/2//g" > POR.rev.names
# Get the forward records that have a match in the rev list
grep -F -A 3 -f POR.rev.names s_6_1_sequence.fastq | grep -v "^\-\-" > POR.pair.for.fastq
# Extract the names of those forward reads
grep "^@" POR.pair.for.fastq | sed -e "s/\/1//g" > POR.pair.for.names
# Get the reverse records which had a match in the forward file
grep -F -A 3 -f POR.pair.for.names s_6_2_sequence.fastq | grep -v "^\-\-" > POR.pair.rev.fastq
rm POR.*.names
