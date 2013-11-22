#!/bin/bash
## Prototype pipeline for the Mexico City imputation to be performed on Beagle.
##  This pipeline is set up over a single chromosome.
##
## Author: Vassily Trubetskoy
## Date: 11-21-2013

### CONSTANTS
## PLINK files for the raw data
bed='/nas40t2/jason/projects/Paper2013/mexico.city.2/datasets/mexico.city.2_cleaned_chr22top1K.bed' ## binary genotype data
bim='/nas40t2/jason/projects/Paper2013/mexico.city.2/datasets/mexico.city.2_cleaned_chr22top1K.bim' ## marker information
fam='/nas40t2/jason/projects/Paper2013/mexico.city.2/datasets/mexico.city.2_cleaned_chr22top1K.fam' ## sample information

## 1000G phased reference panel
map='/nas40t0/vasya/impute2_reference_data/genetic_map_chr22_combined_b37.txt' ## recombination map
haps='/nas40t0/vasya/impute2_reference_data/ALL.chr22.integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nosing.haplotypes' ## known haplotypes
legend='/nas40t0/vasya/impute2_reference_data/ALL.chr22.integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nosing.legend' ## marker information
gens='data/subset_test.gens' ## CHIAMO genotype data
sample='data/subset_test.sample' ## sample file
#strand='' ## strand orientation for .gens markers
impute_output='data/subset_test' ## raw output of impute2

### WORKFLOW
## Convert binary PLINK to PED/MAP
plink --bfile ${bed%%.bed} --recode --out ${bed%%.bed}

## Convert to GEN/SAMPLE format
gtool -P --ped ${bed%%.bed}.ped --map ${bed%%.bed}.map --og ${gens} --os ${sample}

## TODO: make a strand orientation file

## Split chromosome files into genomic block files
\
## Phase and impute over each block
impute2 \
 -m ${map} \
 -h ${haps} \
 -l ${legend} \
 -g ${gens} \
 -int 20.4e6 20.5e6 \
 -Ne 20000 \
 -o ${impute_output}
# -strand_g ${stand} 

## Convert IMPUTE2 output back to PLINK




