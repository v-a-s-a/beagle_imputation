beagle_imputation
=================

Pipeline for running imputation on Beagle.
![Imputation schematic from Bryan Howie](images/imputation_schematic.png)

Image Credit: Bryan Howie. <http://home.uchicago.edu/~/bhowie/research.html>

## Pilot Project :: Imputation in Mexican Americans
 This imputation pipeline is preliminary and has not been fully tested. Our initial dataset consisted of ~1,500 samples and ~400,000 SNPs. The reference genome was split into 5mb chunks (script not under version control yet). This repo contains a test script for genegate to make sure that everything ran appropriately.
 
 NOTE: We tested on genegate using the branch "master" and ran on beagle using the branch "beagle". The final version of the pipeline is under the beagle branch.

## Parallelization

 Take a look at the [http://wiki.ci.uchicago.edu/Beagle/](Beagle wiki) for system specs. It is a compute heavy machine: the cray nodes have low RAM and many cores. The best approach is to use well implemented threads.
 

## Preprocessing:
  * Split reference by chromosome
  * Split input data by chromosome
  * Match variant IDs between reference and directly typed variants
  * Ensure that there are no strand mismatches
  * General genotype QC of directly typed variants

## Imputation Pipeline (for autosomes):
  1. Check human genome reference version  of directly typed data (b37).
  2. Check for strand alignment issues.
  3. Phase by chromosome with SHAPEIT2.
  4. Impute by 5MB chunk with IMPUTE2.
  5. Drop poorly imputed markers (IMPUTE info).
