#!/usr/bin/env nextflow

// Define parameters
params.ref_fasta = "./data/chrX.fa"
params.ref_gtf = "./data/chrX.gtf"
params.reads = "./path/to/your/fastq_data"
params.strand = 0

process trim {
    publishDir "./results/TRIMMED"

    input:
    tuple val(sampleid), path(reads)

    output:
    path "*"
    path "*.fq.gz", emit: trimmed

    script:
    """
    trim_galore --paired -q 20 --gzip --basename ${sampleid}_trimmed ${reads}
    """
}

process QC {
    publishDir "./results/QC_reports"

    input:
    path reads

    output:
    path "*"

    script:
    """
    fastqc ${reads}
    multiqc *fastqc*

    mkdir FASTQC
    mv *fastqc* FASTQC
    """
}

process INDEX {
    publishDir "./results/INDEX"

    input:
    path fasta
    path gtf

    output:
    path "*", emit: index

    script:
    """
    STAR --runMode genomeGenerate --genomeDir index --genomeFastaFiles ${fasta} --sjdbGTFfile ${gtf}
    """
}

process MAPPING {
    publishDir "./results/MAPPING"

    input:
    tuple val(sampleid), path(read1), path(read2), path(index)

    output:
    path "*"
    path "*.bam", emit: bams

    script:
    """
    STAR --genomeDir ${index} --readFilesIn ${read1} ${read2} --outSAMtype BAM SortedByCoordinate --outFileNamePrefix ${sampleid} --readFilesCommand zcat
    """
}

process FEATURE_COUNT {
    publishDir "./results/Feature_Counts"

    input:
    path bams
    path gtf
    val(strand)

    output:
    path "*"

    script:
    """
    featureCounts -s ${strand} -p --countReadPairs -t exon -g gene_id -Q 10 -a ${gtf} -o gene_count ${bams}
    multiqc gene_count*
    """
}

workflow {
    ref_fasta_ch = Channel.fromPath(params.ref_fasta)
    ref_gtf_ch = Channel.fromPath(params.ref_gtf)
    reads_ch = Channel.fromFilePairs(params.reads)
    strand_ch = Channel.of(params.strand)

    trim(reads_ch).set { trimmed }

    raw_fastq = reads_ch.map { items -> items[1] }.flatten().collect()
    trimmed_fastq = trimmed.trimmed.flatten().collect()
    raw_fastq.mix(trimmed_fastq).collect() | QC

    INDEX(ref_fasta_ch, ref_gtf_ch).set { INDEX }

    trimmed.trimmed.map { read1, read2 ->
        tuple("${read1.getFileName().toString().split('_trimmed')[0]}", read1, read2)
    } | combine(INDEX) | MAPPING | set { bams }

    bams.bams.collect().set { finalbams }
    FEATURE_COUNT(finalbams, ref_gtf_ch, strand_ch)
}
