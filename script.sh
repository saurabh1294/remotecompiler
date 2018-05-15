#!/bin/bash

########################################################################
#	- This is the main script that is used to compile/interpret the source code
#	- The script takes 3 arguments
#		1. The compiler that is to compile the source file.
#		2. The source file that is to be compiled/interpreted
#		3. Additional argument only needed for compilers, to execute the object code
#	
#	- Sample execution command:   $: ./script.sh g++ file.cpp ./a.out
#	
########################################################################

compiler=$1
file=$2
output=$3
addtionalArg=$4


########################################################################
#	- The script works as follows
#	- It first stores the stdout and std err to another stream
#	- The output of the stream is then sent to respective files
#	
#	
#	- if third arguemtn is empty Branch 1 is followed. An interpretor was called
#	- else Branch2 is followed, a compiler was invoked
#	- In Branch2. We first check if the compile operation was a success (code returned 0)
#	
#	- If the return code from compile is 0 follow Branch2a and call the output command
#	- Else follow Branch2b and output error Message
#	
#	- Stderr and Stdout are restored
#	- Once the logfile is completely written, it is renamed to "completed"
#	- The purpose of creating the "completed" file is because NodeJs searches for this file 
#	- Upon finding this file, the NodeJS Api returns its content to the browser and deletes the folder
#
#	
########################################################################



START=$(date +%s.%2N)
#Branch 1
if [ "$output" = "" ]; then
    $compiler /usr/bin/runner/$file -< $"/usr/bin/runner/inputFile" #| tee /usr/bin/runner/output.txt
#Branch 2
else
	#In case of compile errors, redirect them to a file
        $compiler /usr/bin/runner/$file $addtionalArg #&> /usr/bin/runner/errors.txt
	#Branch 2a
	if [ $? -eq 0 ];	then
		$output -< $"/usr/bin/runner/inputFile" #| tee /usr/bin/runner/output.txt    
	#Branch 2b
	#else
	    #echo "Compilation Failed"
	    #if compilation fails, display the output file	
	    #cat /usr/bin/runner/errors.txt
	#fi
fi

#exec 1>&3 2>&4

