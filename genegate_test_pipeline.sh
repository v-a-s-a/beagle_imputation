#!/bin/bash
## Prototype pipeline for the Mexico City imputation to be performed on Beagle.
##  This pipeline is set up over a single chromosome.
##
## Author: Vassily Trubetskoy
## Date: 11-21-2013

### CONSTANTS
## PLINK files for the raw data
bed='' ## binary genotype data
bim='' ## marker information
fam='' ## sample information

## 1000G phased reference panel
map='' ## recombination map
haps='' ## known haplotypes
legend='' ## marker information
gens='' ## CHIAMO genotype data
strand='' ## strand orientation for .gens markers


### WORKFLOW
## Convert binary PLINK to PED/MAP
plink --bfile ${bed%%.bed} --recode --out tmp

## Convert to GEN/SAMPLE format
gtool -P --ped myPlinkTextData.ped --map myPlinkTextData.map --og myGtoolTextData.gen --os myGtoolTextData.sample

## TODO: make a strand orientation file

## Split chromosome files into genomic block files

## Phase and impute over each block
impute2 \
 -m ./Example/example.chr22.map \
 -h ./Example/example.chr22.1kG.haps \
 -l ./Example/example.chr22.1kG.legend \
 -g ./Example/example.chr22.study.gens \
 -strand_g ./Example/example.chr22.study.strand \
 -int 20.4e6 20.5e6 \
 -Ne 20000 \
 -o ./Example/example.chr22.one.phased.impute2

