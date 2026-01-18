<div align="center">

# 🧬 RNASeq_Pipeline

**A comprehensive, scalable, and efficient Nextflow-based pipeline for RNA-seq analysis.**

[![Nextflow](https://img.shields.io/badge/Nextflow-%E2%89%A522.10.0-2496ED?logo=nextflow&logoColor=white)](https://www.nextflow.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FastQC](https://img.shields.io/badge/QC-FastQC-brown)](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
[![STAR](https://img.shields.io/badge/Aligner-STAR-blue)](https://github.com/alexdobin/STAR)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[Overview](#-overview) •
[Workflow](#-workflow) •
[Installation](#-installation) •
[Usage](#-usage) •
[Configuration](#-configuration) •
[Outputs](#-outputs)

</div>

---

## 📖 Overview

**RNASeq_Pipeline** automates the end-to-end process of RNA sequencing analysis. Designed for reproducibility and speed, it handles everything from raw read trimming to gene expression quantification.

Inspired by modern best practices in bioinformatics, this pipeline ensures that your research is built on a solid foundation of quality control and accurate mapping.

## ✨ Key Features

| Feature | Tool Used | Description |
| :--- | :--- | :--- |
| **Trimming** | [Trim Galore](https://github.com/FelixKrueger/TrimGalore) | Removes low-quality reads and adapter contamination. |
| **Quality Control** | [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) & [MultiQC](https://multiqc.info/) | Generates comprehensive quality reports for raw and trimmed data. |
| **Indexing** | [STAR](https://github.com/alexdobin/STAR) | Creates optimized genome indexes for ultra-fast mapping. |
| **Alignment** | [STAR](https://github.com/alexdobin/STAR) | Maps paired-end reads to the reference genome with high accuracy. |
| **Quantification** | [featureCounts](http://bioinf.wehi.edu.au/featureCounts/) | Counts reads mapping to genomic features (genes/exons). |

---

## 🔄 Workflow

The pipeline executes the following steps automatically:

1.  **Trimming:** Raw reads are cleaned.
2.  **QC:** Quality is assessed before and after trimming.
3.  **Indexing:** Reference genome is indexed (if not already provided).
4.  **Mapping:** Reads are aligned to the reference.
5.  **Counting:** Expression matrices are generated.

![Pipeline Diagram](https://github.com/user-attachments/assets/8e905afb-13a5-4da9-9676-c572379ff384)



---

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone [https://github.com/haythem03/Nextflow_RNASeq.git](https://github.com/haythem03/Nextflow_RNASeq.git)
cd Nextflow_RNASeq
```
### Step 2 — Install Nextflow

Ensure Java is installed, then run:

curl -s https://get.nextflow.io | bash

(Optional)

mv nextflow /usr/local/bin

### Step 3 — Prepare Reference Data (required)

Because of GitHub file-size limits, the reference genome `chrX.fa` is split into multiple parts. You **must merge them** before running the pipeline.

cd data
cat chrX\_part\_\* > chrX.fa
md5sum chrX.fa   # optional integrity check
cd ..

Your `data/` folder must contain:

-   `chrX.fa` – merged reference genome
-   `chrX.gtf` – annotation file

## 🏃 Usage

### Run with default parameters

nextflow run Nextflow\_Pipeline.nf

### Run with custom parameters

nextflow run Nextflow\_Pipeline.nf \\
  --reads "data/\*\_{1,2}.fastq.gz" \\
  --ref\_fasta "/path/to/genome.fa" \\
  --ref\_gtf "/path/to/genes.gtf" \\
  --strand 1

## ⚙️ Configuration

Parameters can be modified inside `Nextflow_Pipeline.nf` or overridden at runtime.

ParameterDefaultDescription`params.readsdata/reads/*_{1,2}.fastq.gz`Input paired-end FASTQ files`params.ref_fastadata/chrX.fa`Reference genome FASTA`params.ref_gtfdata/chrX.gtf`Gene annotation file`params.strand0`0 = unstranded, 1 = stranded, 2 = reverse`params.outdirresults/`Output directory

## 📂 Outputs

After completion, results are organized as follows:

results/
├── TRIMMED/         # Cleaned FASTQ files
├── QC\_reports/      # FastQC and MultiQC summaries
├── INDEX/           # STAR genome indices
├── MAPPING/         # Sorted BAM alignment files
└── Feature\_Counts/  # Gene expression matrices

Each folder contains reproducible intermediate files suitable for auditing or re-analysis.

## 🤝 Contributing

Contributions are welcome.

1.  Fork the repository
2.  Create a feature branch
3.  Submit a Pull Request

For major changes, please open an issue first to discuss your proposal.

## 📄 License

This project is licensed under the **MIT License**. See the `LICENSE` file in the repository for details.
