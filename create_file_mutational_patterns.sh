#!/usr/bin/bash
#mutect_files='/home/groups/mcweeney_lab/jengs/HNSCC/mut_patterns_vcf/*somatic.chrs.vcf'
mutect_files='/home/groups/mcweeney_lab/jengs/HNSCC/mut_patterns_vcf/*vcf'
for eachfile in $mutect_files
do
	echo ${eachfile}
	echo ${eachfile/.vcf/.somatic.vcf}
	echo ${eachfile/.vcf/.somatic.vcf.gz}
	echo ${eachfile/.vcf/.somatic.chrs.vcf}
	sample_name=`/home/exacloud/gscratch/mcweeney_lab/jengs/software/bcftools-1.20/bcftools head ${eachfile}  | grep 'tumor_sample'`
	sample_name=${sample_name/"##tumor_sample="/""}
	normal_name=`/home/exacloud/gscratch/mcweeney_lab/jengs/software/bcftools-1.20/bcftools head ${eachfile}  | grep 'normal_sample'`
	normal_name=${normal_name/"##normal_sample="/""}
	echo ${sample_name}
	echo ${normal_name}
        srun -p exacloud -A mcweeney_lab --time=1440 /home/exacloud/gscratch/mcweeney_lab/jengs/software/bcftools-1.20/bcftools view -i'FILTER="PASS"' ${eachfile} > ${eachfile/.vcf/.somatic.vcf}
        srun -p exacloud -A mcweeney_lab --time=1440 /home/exacloud/gscratch/mcweeney_lab/jengs/software/htslib-1.14/bgzip ${eachfile/.vcf/.somatic.vcf}
        srun -p exacloud -A mcweeney_lab --time=1440 /home/exacloud/gscratch/mcweeney_lab/jengs/software/htslib-1.14/tabix ${eachfile/.vcf/.somatic.vcf.gz}
        srun -p exacloud -A mcweeney_lab --time=1440 /home/exacloud/gscratch/mcweeney_lab/jengs/software/bcftools-1.20/bcftools view -r 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y ${eachfile/.vcf/.somatic.vcf.gz} | grep -v "ID=GL" | grep -v "ID=NC" | grep -v "ID=MT"> ${eachfile/.vcf/.somatic.chrs.vcf}
	printf "${eachfile/.vcf/.somatic.chrs.vcf}\t${sample_name}\t${normal_name}\n" >> file_for_mutational_signatures.txt
#	printf "${eachfile}\t${sample_name}\t${normal_name}\n" >> file_for_mutational_signatures.txt
done
