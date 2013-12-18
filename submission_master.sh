#!/bin/bash

## launch 24 parallel environments on 24 nodes.
for i in "test"; do
	## pass in the block file for each node.
	blockFile="/lustre/beagle/vasya/mex_genotypes/chunk_${i}.txt"
	qsub -v INPUTFILE="$blockFile" -N "mex.am.${i}" /lustre/beagle/vasya/beagle_imputation/batch_impute2.pbs
done

