beagle_imputation
=================

Pipeline for running imputation on Beagle.
[[/images/imputation_schematic.png]]

Image Credit: Bryan Howie here at the Univeristy of Chicago. <http://home.uchicago.edu/~/bhowie/research.html>

## Miscellaneous Notes:
 This imputation pipeline is preliminary and has not been tested. We deceided against prephasing with SHAPEIT2, in order to simplify the overall workflow. Instead, we will allow IMPUTE2 to phase our data.

  All steps with ??? need to have scripts or tools written to perform the function.

  It is possible that we have to insert a LiftOver step into the workflow in order to convert data from b36 to b37.

## Preprocessing:
  * Split reference by chromosome
  * Split input data by chromosome
  * match variant IDs

## Workflow:
  1. Copy reference and raw data to node.
  2. Convert binary PLINK to PED/map.
  3. GTOOL: Convert PLINK files to CHIAMO format.
  4. ???: make strand orientation file.
  5. ???: split chromosome files into genomic blocks.
    - Each chunk will be submitted to 1 of 24 cores on the node.
  6. IMPUTE2: input 1000genomes reference and block file.
  7. ???: imputation QC.
    - Perhaps set an output filter in step 5 to simply ignore low wuality variants.
  8. GTOOL: convert IMPUTE2 output files to PLINK format.
  9. heritability analyses.

