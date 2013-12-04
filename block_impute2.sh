#!/bin/bash

## 1000 genomes reference data directory
refDataDir="/lustre/beagle/vasya/1000g_reference"
## mexico city data directory
genoDataDir="/lustre/beagle/vasya/mex_genotypes"
## output
outputDir="/lustre/beagle/vasya/imputed_data"

## file defining genomic regions of imputation
blockFile=$1


## extract block regions defined in a file
while read line; do
  ## pull block data into variables
  chr=$( echo $line | cut -f 1 )
  start=$( echo $line | cut -f 2 )
  end=$( echo $line | cut -f 3 )

  ## construct file references from block information
  ## genotype data
  gens="${genoDataDir}/mexico.city.2_cleaned_${chr}.gens"
  sample="${genoDataDir}/mexico.city.2_cleaned_${chr}.sample"
  ## reference data
  map="${refDataDir}/genetic_map_chr${chr}_combined_b37.txt"
  haps="${refDataDir}/ALL.chr${chr}.integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nosing.haplotypes"
  legend="${refDataDir}/ALL.chr${chr}.integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nosing.legend"
  ## output location
  imputeOutput="${outputDir}/mexico.city.2_cleaned_IMPUTED_chr${chr}"

  ## submit the command in the background
  impute2 \
    -m ${map} \
    -h ${haps} \
    -l ${legend} \
    -g ${gens} \
    -int ${start} ${end} \
    -Ne 20000 \
    -o ${imputeOutput} &

done < ${blockFile}

wait
