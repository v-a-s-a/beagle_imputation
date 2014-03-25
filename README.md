beagle_imputation
=================

Pipeline for running imputation on Beagle.
![Imputation schematic from Bryan Howie](images/imputation_schematic.png)

Image Credit: Bryan Howie here at the Univeristy of Chicago. <http://home.uchicago.edu/~/bhowie/research.html>

## Pilot Project :: Imputation in Mexican Americans
 This imputation pipeline is preliminary and has not been fully tested. Our initial dataset consisted of ~1,500 samples and ~400,000 SNPs. The reference genome was split into 5mb chunks (ask Jason for script). This repo contains a test script for genegate to make sure that everything ran appropriately.

## Parallelization

 Beagle's uses the Portable Batch System (PBS) for resource management and scheduling.

## Preprocessing:
  * Split reference by chromosome
  * Split input data by chromosome
  * match variant IDs between reference and directly typed variants

## Workflow Outline (pilot project specific):
  1. Copy reference and raw data to node.
  2. Convert binary PLINK to PED/map.
  3. GTOOL: Convert PLINK files to CHIAMO format.
  5. split chromosome files into genomic blocks.
    - Each chunk will be submitted to 1 of 24 cores on the node.
  6. IMPUTE2: input 1000genomes reference and block file.
  7. Magical imputation QC
    - Standard imputation quality metric is the multi-locus LD calculated in the reference panel. This quantity is represented in the info column of the IMPUTE2 snp output file.
  8. GTOOL: convert IMPUTE2 output files to PLINK format.
  9. heritability analyses.

