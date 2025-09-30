#!/bin/sh

# ------------------------------------------------------------------------------
# --- Run ADMIXTURE in cross-validation mode
# ------------------------------------------------------------------------------
module load admixture/1.3.0

IN_BED=$1
K=$2
THREADS=${3:-1}

OUT_PREFIX=$(basename $IN_BED .bed)

for i in `seq 1 15`; do

        RANDOM=`date +%N | sed s/...$//`
        SEED=$RANDOM

                admixture --seed $SEED ${IN_BED} ${K} --cv | tee $OUT_PREFIX.${K}.$i.out

        mv $OUT_PREFIX.${K}.P $OUT_PREFIX.${K}.$i.P
        mv $OUT_PREFIX.${K}.Q $OUT_PREFIX.${K}.$i.Q

        done

done
