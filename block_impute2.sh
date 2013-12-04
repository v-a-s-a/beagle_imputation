#!/bin/bash

## 1000 genomes reference data directory
refDataDir=""
## mexico city data directory
genoDataDir=""
## output
outputDir=""

## file defining genomic regions of imputation
blockFile=""


## extract block regions defined in a file
while read line; do
  ## pull block data into variables
  chr=$( echo $line | cut -f 1 )
  start=$( echo $line | cut -f 2 )
  end=$( echo $line | cut -f 3 )

  ## construct file references from block information
  ## genotype data
  bed="${genoDataDir}/mexico.city.2_cleaned_chr${chr}.bed"
  bim="${genoDataDir}/mexico.city.2_cleaned_chr${chr}.bim"
  fam="${genoDataDir}/mexico.city.2_cleaned_chr${chr}.fam"
  ## reference data
  map="${refDataDir}"
  haps="${refDataDir}"
  legend="${refDataDir}"
  gens="${refDataDir}"
  sample="${refDataDir}"
  ## output location
  imputeOutput="${outputDir}/mexico.city.2.IMPUTED_chr${chr}"

  ## submit the command in the background
  impute2 \
    -m ${map} \
    -h ${haps} \
    -l ${legend} \
    -g ${gens} \
    -int ${start} ${end} \
    -Ne 20000 \
    -o ${imputeOutput} &

done < ${blockData}

