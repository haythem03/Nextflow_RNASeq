# Nextflow_RNASeq

**RNASeq_Pipeline** is a comprehensive, flexible, and efficient Nextflow-based pipeline for analyzing RNA-seq data. It automates the process of trimming, quality control, genome indexing, read mapping, and feature counting, making RNA-seq analysis more reproducible and streamlined.

## Features

- **Trimming**: Removes low-quality reads using [Trim Galore](https://github.com/FelixKrueger/TrimGalore).
- **Quality Control**: Generates quality control reports using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and aggregates them with [MultiQC](https://multiqc.info/).
- **Genome Indexing**: Creates genome indexes using [STAR](https://github.com/alexdobin/STAR) for fast read mapping.
- **Read Mapping**: Aligns paired-end RNA-seq reads to the reference genome using STAR, producing sorted BAM files.
- **Feature Counting**: Quantifies gene expression using [featureCounts](http://bioinf.wehi.edu.au/featureCounts/).

## Installation

### 1. Clone the Repository
Clone this repository to your local machine:

```bash
git clone (https://github.com/haythem03/Nextflow_RNASeq.git)
cd Nextflow_RNASeq

