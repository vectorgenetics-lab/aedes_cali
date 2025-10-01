#!/bin/bash
##Compute feature using vcftools
#-----------------------------------------------------------------------------
module load vcftools/0.1.16

INPUT=aedes-california.vcf.gz

#Central
#GC1
#GC2
#GC3
#Chico
#Citrus
#Clovis19
#Sacramento
#Shasta
#SouthAfrica
#Stockton
#Winters
#Yuba

#for pop in GC1; do
for pop in GC2 GC3 GC1; do

                ### Compute Tajima D
                vcftools --gzvcf $INPUT \
                        --keep ./populations/$pop \
                        --TajimaD 100000 \
                        --out ./output-vcftools/$pop-taj100k

                ### Compute inbreeding stat (F)
                vcftools --gzvcf $INPUT \
                        --keep ./populations/$pop \
                        --het \
                        --out $pop-l4

                ### Compute pi
                vcftools --gzvcf $INPUT \
                        --keep ./populations/$pop \
                        --window-pi 100000 \
                        --out ./output-vcftools/$pop-pi100k

done
