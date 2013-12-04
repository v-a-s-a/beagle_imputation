#!/bin/bash

## launch 24 parallel environments on 24 nodes.
for i in {1..24}; do
	## pass in the block file for each node.
	blockFile="${i}"
	qsub -v INPUTFILE="$blockFile" -N "mex.am.${i}" batch_impute2.pbs

done

