# Mutational Patterns Workflow
Workflow used to process vcf files for Mutational Patterns (Biocondcutor) analysis
1. Mutations called using Mutect2
2. vcf files from Mutect2 processed for Mutational Patterns analysis
    1. Keep calls that passed and were somatic
    2. Keep only autosomal and sex chromosomes
    3. Remove headers that included extraneous chromosomes
3. Mutational Patterns implemented in R, using the targets package
