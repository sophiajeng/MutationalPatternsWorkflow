#!/usr/bin/bash
mutect_files='/home/groups/mcweeney_lab/jengs/HNSCC/mut_patterns_vcf/*vcf'
for eachfile in $mutect_files
do
	echo ${eachfile}
	echo ${eachfile/.vcf/.somatic.vcf}
	sample_name=`/home/users/jengs/bcftools-1.20/bcftools head ${eachfile}  | grep 'tumor_sample'`
	sample_name=${sample_name/"##tumor_sample="/""}
	normal_name=`/home/users/jengs/bcftools-1.20/bcftools head ${eachfile}  | grep 'normal_sample'`
	normal_name=${normal_name/"##normal_sample="/""}
	echo ${sample_name}
	echo ${normal_name}
        /home/users/jengs/bcftools-1.20/bcftools view -Ou -i'FILTER="PASS"' ${eachfile} | /home/users/jengs/bcftools-1.20/bcftools filter -r 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y > ${eachfile/.vcf/.somatic.vcf}
#	printf "${eachfile/.vcf/.somatic.vcf}\t${sample_name}\t${normal_name}\n" >> file_for_mutational_signatures.txt
done
