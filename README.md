beagle_imputation
=================

Pipeline for running imputation on Beagle.


## Preprocessing:
  * Split reference by chromosome
  * Split input data by chromosome
  * match variant IDs

## Workflow:
  1. Copy reference and raw data to node.
  2. GTOOL: Convert PLINK files to CHIAMO format.
  3. ???: make strand orientation file.
  4. ???: split chromosome files into genomic blocks.
    - Each chunk will be submitted to 1 of 24 cores on the node.
  5. IMPUTE2: input 1000genomes reference and block file.
  6. ???: imputation QC.
    - Perhaps set an output filter in step 5 to simply ignore low wuality variants.
  7. GTOOL: convert IMPUTE2 output files to PLINK format.
  8. heritability analyses.

