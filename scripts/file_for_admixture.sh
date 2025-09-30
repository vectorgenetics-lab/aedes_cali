#!/bin/bash

# ----------------------------------------------------------------------------------------
# --- Make datasets for ADMIXTURE replicates
# ----------------------------------------------------------------------------------------
module load plink/1.90p

file=two_islands

ls   ./aedes-*.bed | sed -e "s/\(.*\).bed/\1.bed \1.bim \1.fam/" >  $file-genome

plink --merge-list  $file-genome \
                --make-bed \
                --out  $file-genome

RANDOM=`date +%N | sed s/...$//`

for i in `seq 1 3`
do
        SEED=$RANDOM
                plink \
                        --seed $SEED \
                        --bfile $file \
                        --thin-count 50000 \
                        --make-bed \
                        --out $file-50k-$i

done

