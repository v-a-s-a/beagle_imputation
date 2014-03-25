beagle_imputation
=================

Pipeline for running imputation on Beagle.
![Imputation schematic from Bryan Howie](images/imputation_schematic.png)

Image Credit: Bryan Howie here at the Univeristy of Chicago. <http://home.uchicago.edu/~/bhowie/research.html>

## Pilot Project :: Imputation in Mexican Americans
 This imputation pipeline is preliminary and has not been fully tested. Our initial dataset consisted of ~1,500 samples and ~400,000 SNPs. The reference genome was split into 5mb chunks (script not under version control yet). This repo contains a test script for genegate to make sure that everything ran appropriately.
 
 NOTE: We tested on genegate using the branch "master" and ran on beagle using the branch "beagle". The final version of the pipeline is under the beagle branch.

## Parallelization

 Take a look at the [http://wiki.ci.uchicago.edu/Beagle/](Beagle wiki) for system specs.
 
 There were a few gotchas with regards to memory per node, and I'll have to detail the final scheme we used here at a later date.

## Preprocessing:
  * Split reference by chromosome
  * Split input data by chromosome
  * Match variant IDs between reference and directly typed variants
  * Ensure that there are no strand mismatches
  * General genotype QC of directly typed variants

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

