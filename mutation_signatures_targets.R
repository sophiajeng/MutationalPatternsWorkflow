#_targets.R file
library(targets)
source("mut_sign_functions.R")
#outputdir<-"/home/groups/mcweeney_lab/jengs/HNSCC/mutational_patterns_output/"
#outputdir<-"/Users/jengs/OneDrive - Oregon Health & Science University/From_Box/Pre-Share/MKM/HNSCC/mutational_patterns_output/"

load("/Users/jengs/OneDrive - Oregon Health & Science University/From_Box/Pre-Share/MKM/HNSCC/PureCN/cl_barcode_pairs.RData")
#home_dir<-"/Users/jengs/OneDrive - Oregon Health & Science University/From_Box/Pre-Share/MKM/HNSCC/"
ref_genome <- "BSgenome.Hsapiens.UCSC.hg19"
library(ref_genome, character.only = TRUE)


vcf_file<-readInFile("file_for_mutational_signatures_vep.txt")
annot_vcf_file<-createAnnotFile(vcf_file,samp.bams)
grl<-getGrl(paste0(home_dir,"geno_mutect2_vcf_files/",basename(annot_vcf_file[,"vcf_file"])),annot_vcf_file[,"tumor"])


