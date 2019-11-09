#!/bin/sh

###############################################################################
# Merge all output files in job directories
###############################################################################
rm -f output.txt

for dataFile in */*.BQ/data.txt
do
	cat $dataFile >>$1
done

###############################################################################
# Create plot file with gnuplot
###############################################################################
cat  <<gnuplotScript | gnuplot
set term png small
set output "$2"

set title "Current vs. Power (Resistance = $3 ohms)"
set xlabel "Current (Amperes)"
set ylabel "Power (Watts)"

plot '$1' with lines
gnuplotScript

