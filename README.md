# RNASeq_Pipeline

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

```

### 2. Prepare Input Data
Create a `data` directory in the root of the project and place your input files as follows:
- `data/chrX.fa`: Reference genome in FASTA format
- `data/chrX.gtf`: Reference gene annotation in GTF format.


You can also modify the paths in the `Nextflow_Pipeline.nf` file if your data files are located elsewhere.

### 3. Install Nextflow

Make sure [Nextflow](https://www.nextflow.io/) is installed on your machine. You can install it via the following command:

```bash
curl -s https://get.nextflow.io | bash
```

## Usage

Once the setup is complete, you can run the pipeline with Nextflow:

```bash
nextflow run Nextflow_Pipeline.nf
```

The pipeline will process your RNA-seq data, and results will be saved in the `results/` directory, with the following output structure:
- `results/TRIMMED/`: Trimmed FASTQ files after quality filtering.
- `results/QC_reports/`: FastQC reports and a MultiQC summary.
- `results/INDEX/`: STAR genome index files.
- `results/MAPPING/`: Aligned BAM files from STAR mapping.
- `results/Feature_Counts/`: Gene expression counts from featureCounts.

## Pipeline Workflow

1. **Trimming**: Raw reads are trimmed for adapter contamination and low-quality bases using Trim Galore.
2. **Quality Control**: FastQC is run on raw and trimmed reads to assess quality, followed by MultiQC to combine all FastQC results into one report.
3. **Genome Indexing**: STAR is used to generate a genome index from the reference FASTA and GTF files.
4. **Read Mapping**: Paired-end reads are aligned to the reference genome using the STAR aligner.
5. **Feature Counting**: The aligned BAM files are processed with featureCounts to count the number of reads aligned to each gene.

   ![image](https://github.com/user-attachments/assets/8e905afb-13a5-4da9-9676-c572379ff384)



## Downloading and Merging the Reference Genome

Due to size limitations, the `chrX.fa` reference genome is provided in split chunks. Follow these steps to merge the chunks back into a single FASTA file:

1. Clone the repository and navigate to the `data/` directory:
   ```bash
   git clone (https://github.com/haythem03/Nextflow_RNASeq.git)
   cd Nextflow_RNASeq

   ```

2. Merge the split files into a single `chrX.fa` file:
   ```bash
   cat chrX_part_* > chrX.fa
   ```

3. Verify the integrity of the merged file (optional):
   ```bash
   md5sum chrX.fa
   ```
   (You can include the checksum value here for users to compare.)

4. Proceed with the pipeline execution as described in the instructions.

## Customization

You can customize various parameters by editing the `Nextflow_Pipeline.nf` file or by providing them as Nextflow parameters when running the pipeline. For example:
- `params.ref_fasta`: Path to the reference genome FASTA file.
- `params.ref_gtf`: Path to the reference GTF file.
- `params.reads`: Path to the paired-end FASTQ files.
- `params.strand`: Strand-specific counting (0 for unstranded, 1 for stranded).

## Contributing

Feel free to open issues, fork the repository, or submit pull requests for bug fixes or improvements. Contributions are always welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


