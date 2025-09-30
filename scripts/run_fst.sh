# Calculate the Fst between pure Anopheles species, before hybrization time
## Compare coluzzii vs. gambiae

module load vcftools/0.1.16

pop1=$1
pop2=$2

vcftools --gzvcf  aedes-cali.vcf.gz \
        --weir-fst-pop ./$pop1 --weir-fst-pop ./$pop2 \
        --out ${pop1}_vs_${pop2}

sort -r -k 3,3 ${pop1}_vs_${pop2}.weir.fst | grep -v "\-nan" | grep -v "\-" > ${pop1}_vs_${pop2}.tmp.weir.fst 
cat ${pop1}_vs_${pop2}.tmp.weir.fst  | awk '{if($3 > 0.9){print}}' > ${pop1}_vs_${pop2}.nearlyfixed.weir.fst 
cat ${pop1}_vs_${pop2}.tmp.weir.fst  | awk '{if($3 > 1){print}}' > ${pop1}_vs_${pop2}.fixed.weir.fst
