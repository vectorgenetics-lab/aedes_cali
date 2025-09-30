# Genetics of range expansion and admixture of *Aedes aegypti* populations in California

This repository contains the code and workflows used to analyze sequencing data and generate the results presented in:

**Genetics of range expansion and admixture of *Aedes aegypti* populations in California**  
Melina Campos

Vector Genetics Laboratory, Department of Pathology, Microbiology and Immunology, UC Davis, Davis, CA, USA. 



## Contents

- `workflow/` — reproducible scripts and pipelines for:
  - Quality control & trimming (Trimmomatic)
  - Read mapping (BWA-MEM) and statistics (Qualimap)
  - Variant calling and filtering (FreeBayes)
  - LD pruning and PCA (scikit-allel, R)
  - F<sub>ST</sub> estimation and NJ tree construction (scikit-allel, ape)
  - Admixture analysis (ADMIXTURE, CLUMPAK)
  - AIMs detection and nucleotide diversity (VCFtools)
- `notebooks/` — Jupyter notebooks with exploratory analyses and plotting code.
- `results/` — example of outputs (figures, tables). enerated.
- `figures/` — code-generated figures for the manuscript.


## Data availability

Raw sequencing data: NCBI BioProject **[PRJNA385349](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA385349)** **[PRJNA725510](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA725510)**  **[PRJNA607233](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA607233)** and additional datasets listed in the manuscript (Table S1).  
Due to size, raw and processed genomic data are not stored in this repository.  
Scripts assume you have downloaded and organized data locally — see `data/README.md`.



## Software requirements

Analyses were performed with the following tools:

- **Trimmomatic v0.36**
- **BWA-MEM v0.7.15**
- **Qualimap v2.2**
- **FreeBayes v1.0.1**
- **VCFtools v0.1.15**
- **scikit-allel v1.3.0 (Python 3.10)**
- **R v4.2** with packages:
  - `ape`
  - `ggplot2`
  - `data.table`
