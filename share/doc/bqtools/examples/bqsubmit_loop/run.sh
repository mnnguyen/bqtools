#!/bin/sh

cat <<example

The program "ohms_law" calculates the voltage and power from current and 
resistance data stored in the "input.dat" file.

To run this example:	
--------------------
    $ make
    $ bqsubmit

To run others examples:
-----------------------        
    $ bqsubmit -f bqsubmit.dat2  # Submit a minimum of 5 jobs at any time.
    $ bqsubmit -f bqsubmit.dat3	 # Group jobs into 5 micro jobs.
    $ bqsubmit -f bqsubmit.dat4  # Group jobs into 5 micro jobs and submit a minimum of 3 jobs at any time.
    $ bqsubmit -f bqsubmit.dat5  # Varying 2 parameters in a single loop.
    $ bqsubmit -f bqsubmit.dat6  # Varying 2 parameters in 2 loops.

    Remove all previous files before submitting again (rm -fr *.BQ *.log *.status)


example
