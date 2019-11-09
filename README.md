# bqTools
Batch Queuing Tools

The Batch Queuing Tools (bqTools) is a set of tools to help submit jobs that perform the same work using the same command, but operate on different sets of inputs.  It use Slurm scheduler job array mechanism and GNU Parallel features to control execution of jobs.

The current features include : 
* Automatic parameters exploration
* PRE and POST processing at the job or batch level
* Batch monitoring
* Recovery of a stopped batch



bqsubmit configuration file:

```
#------------------------------------------------------------------------------
# Batch name (Optional, Default: BATCH)
#
#   Specify a name for this batch of jobs.  The specified name will appear 
#   along with the job id number when querying running jobs on the system.
#   It also be used to identify all necessary scripts and job directories.
#
# Examples:
#   batchName=BATCH
#------------------------------------------------------------------------------
#batchName=BATCH

#------------------------------------------------------------------------------
# Concurrent jobs (Optional, Default: 800)
#
#   Limit the maximum of concurrent jobs to the queueing system.  Some systems
#   may set a maximum number of jobs per user or per account.
#
# Examples:
#   concurrentJobs=800    # Maximum of 800 concurrent jobs queued and running 
#------------------------------------------------------------------------------
#concurrentJobs=800

#------------------------------------------------------------------------------
# Command (Required)
#
#   Command to execute for each work in each job subdirectory.  Multiple 
#   commands are allowed.
#
# Examples:
#   command=sh myscript.sh
#   command=cat abc.txt | bc
#------------------------------------------------------------------------------
command=

#------------------------------------------------------------------------------
# Template files (Required)
#  
#   List of ASCII template files where keys (Format: ~~key~~)(ex.: ~~varA~~) 
#   will be replaced by constant or variable values defined in this 
#   configuration file.  Multiple files are separated by a whitespace.
# 
# Examples:
#   templatesFiles=abc.txt    
#   templatesFiles=abc.txt def.txt ghi.txt   
#  
#   See 'Constant values' and 'Variable values' sections.
#------------------------------------------------------------------------------
templateFiles=

#------------------------------------------------------------------------------
# Variable values (Required)
#
#   Keys in template files will be replaced by variable values.  Multiple loops 
#   are supported, one key per loop.  Keys must be preceded by the string 
#   paramX where X is an integer that defined the order of each loop.  
#
# Examples of variables values:
#   param1=a=$(seq 2.0 -0.2 1.6)    # a = 2.0, 1.8, 1.6
#   param1=b=2.0 1.8 1.6            # b = 2.0, 1.8, 1.6
#   param1=c=$(cat abc.txt)         # where abc.txt is a text file with one
#                                      # value per line
#   param1=d=$(awk -F, '{ print $2 }' abc.csv)  
#                                       # where abc.csv is delimited text file
#                                       # that uses a comma to separate values.
#                                       # Select the second column values.
#
# Examples of many loops:
#   param1=a=1 2 
#   param2=b=$(seq 3 4)
#   param3=c=$(seq 5 1 6) 
#
#   will generate:        a b c
#                         1 3 5
#                         1 3 6
#                         1 4 5
#                         1 4 6
#                         2 3 5
#                         2 3 6
#                         2 4 5
#                         2 4 6
#------------------------------------------------------------------------------
param1=
#param2=
#param3=

#------------------------------------------------------------------------------
# Constant values (Optional)
# 
#   Keys in template files will be replaced by constant values.  Specify one key 
#   value pair per line.
#
# Format:
#   key=value    
#    
# Examples:
#   varA=1234
#   varB=abc.txt
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# Variables symbolic links (Optional, Default: 0)
#    
#   Enable symbolic link creation to each job subdirectory.  The symbolic link 
#   name is composed of keys and values generated in each job subdirectory.
#
# Examples:
#   paramSymLinks=0    # Disable symbolic links creation.
#   paramSymLinks=1    # Enable symbolic links creation.
#------------------------------------------------------------------------------
#paramSymLinks=0

#------------------------------------------------------------------------------
# Copy files (Optional)
#
#   Files to be copied in the job directory.  File path is relative to where 
#   the bqsubmit command is launched.  Multiple files are separated by
#   a whitespace.
#
# Examples:
#   copyFiles=abc.txt
#   copyFiles=abc.txt def.txt ghi.txt 
#------------------------------------------------------------------------------
#copyFiles=

#------------------------------------------------------------------------------
# Link files (Optional)
#
#   Symbolic links to be created in the job directory.  File path is relative
#   to where the bqsubmit command is launched.  Multiple files are separated by
#   a whitespace.
#
# Examples:
#   linkFiles=abc.txt
#   linkFiles=abc.txt def.txt ghi.txt 
#------------------------------------------------------------------------------
#linkFiles=

#------------------------------------------------------------------------------
# Submission options (Optional)
#
#   This version of bqtools support all Slurm sbatch options (List of sbatch
#   options:  https://slurm.schedmd.com/sbatch.html).  Multiple options are 
#   separated by a whitespace.  Most frequently used sbatch options:
#
#     --account=name          charge job to specified account
#
#     --cpus-per-task=ncpus   number of cpus required per task
#
#     --mail-type=type        notify on state change: BEGIN, END, FAIL or ALL
#
#     --mail-user=user        who to send email notification for job state
#                             changes
#
#     --mem=MB                minimum amount of real memory
#
#     --mem-per-cpu=MB        maximum amount of real memory per allocated
#                             cpu required by the job.
#
#     --nodes=N               number of nodes on which to run (N = min[-max])
#
#     --time=minutes          time limit
#
# Examples:
#   submitOptions="--mail-type=ALL --mail-user=user@domain.com --nodes=1 --time=1:00"
#   submitOptions="--account=def-nguyenmi --time=1:00"  
#------------------------------------------------------------------------------
#submitOptions=








###############################################################################
# Advanced options                                                            # 
# ----------------                                                            #
#   -Run more than 1 work per scheduling job.                                 #
#   -Advanced key value pairs generation.                                     #
#   -Custom setup in each work directory.                                     #
###############################################################################

#------------------------------------------------------------------------------
#   Use the 2 following options to run more than one work per scheduling job.  
#   Usually used to serialize many short execution (<15 minutes) or to pack 
#   many execution simultaneously for resources optimization (i.e.: if jobs 
#   scheduling is per node).
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Micro jobs (Optional, Default: 1)
#
#   Total works to set per scheduling job.
#
# Examples:
#   microJobs=4    # 4 works will be executed in a single scheduler job
#------------------------------------------------------------------------------
#microJobs=1

#------------------------------------------------------------------------------
# Concurrent micro jobs (Optional, Default: 1)
#
#   Control works execution order within a scheduling job:
#     concurrentMicroJobs=0  (The slurm environment variable $SLURM_NTASKS
#                             will fix the number of concurrent jobs)
#     concurrentMicroJobs=1  (Serial execution of works)
#     concurrentMicroJobs=n  (n parallel execution of works)
#
# Examples:
#   concurrentMicroJobs=2    # 2 works will be executed in parallel  
#------------------------------------------------------------------------------
#concurrentMicroJobs=1

#------------------------------------------------------------------------------
# Keys and values list (Optional)
#
#   May replaced paramX option, set keysList and valuesList to generate a 
#   custom sets of data.
#
# Example 1 (no var link):
#   keysList="varA varB"
#   valuesList="::: 1 2 ::: 3 4"
#
#   will generate:        varA varB
#                            1    3
#                            1    4
#                            2    3
#                            2    4
#
# Example 2 (link varA and varB):
#   keysList="varA varB"
#   valuesList="::: 1 2 :::+ 3 4"
#
#   will generate:        varA varB
#                            1    3
#                            2    4
#
# Example 3 (link varA and varB):
#   keysList="varA varB varC"
#   valuesList="::: 1 2 :::+ 3 4 ::: 5 6"
#
#   will generate:        varA varB varC
#                            1    3    5
#                            1    3    6
#                            2    4    5
#                            2    4    6
#
# Example 4 (link varB and varC)::
#   keysList="varA varB varC"
#   valuesList="::: 1 2 ::: 3 4 :::+ 5 6"
#
#   will generate:        varA varB varC
#                            1    3    5
#                            1    4    6
#                            2    3    5
#                            2    4    6
#  
# Example 5 (link varA and varB and varC):
#   keysList="varA varB varC"
#   valuesList="::: 1 2 :::+ 3 4 :::+ 5 6"
#
#   will generate:        varA varB varC
#                            1    3    5
#                            2    4    6
#
# Example 6 (Equivalent to "param1 = (varA,varB) = load data".txt in bqtools 4.x)
#   keysList="varA varB"
#   valuesList="::: $(awk '{ print $1 }' data.txt) :::+ $(awk '{ print $2 }' data.txt)"
#
#     where data.txt:
#                         0.25 0.35
#                         0.45 0.55
#
#   will generate:        varA varB 
#                         0.25 0.35
#                         0.45 0.55
#
# For more examples on linking arguments:   
#   https://www.gnu.org/software/parallel/parallel_tutorial.html#Linking-arguments-from-input-sources                                     
#------------------------------------------------------------------------------
#keysList=
#valuesList=

#------------------------------------------------------------------------------
# Pre job command (Optional)
#
#   Command to execute in each work directory before submitting to the job 
#   scheduler.  Usually used to setup all required files before performing the
#   work command.  May replaced the copyFiles and linkFiles options.  Multiple 
#   commands are allowed.
#
# Examples:
#   preJob="cp $HOME/data .; ln -s $HOME/data2 data2" 
#------------------------------------------------------------------------------
#preJob=
```
