# Background

I want pile-up plots of H3K27me3 for promoters of “ALKBH1 -> up” ALKBH1-> down & neutral genes.

[note that renames]

# Software versions

## Data

Genome hg38

## Software versions

**deepTools**
- plotHeatmap 3.5.1
- computeMatrix 3.5.1
- plotProfile 3.5.1
- bamCoverage 3.5.1

**bowtie2**
> /vast/palmer/apps/avx2/software/Bowtie2/2.4.2-GCCcore-10.2.0/bin/bowtie2-align-s version 2.4.2
> 64-bit
> Built on r205u07n12.mccleary.ycrc.yale.edu
> Wed Nov  9 14:43:51 UTC 2022
> Compiler: gcc version 10.2.0 (GCC)
> Options: -O2 -ftree-vectorize -march=native -fno-math-errno -fPIC -std=gnu++98 -O2 -ftree-vectorize -march=native -fno-math-errno -fPIC -std=gnu++98 -DPOPCNT_CAPABILITY -DWITH_TBB -std=c++11 -DNO_SPINLOCK -D> WITH_QUEUELOCK=1
> Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}

**samtools 1.16**
- See `samtools.ver` for compilation details

*picard 2.25.6-Java-11*

**trimmomatic PE 0.39**

**FastQC v0.11.9**

**SRA-Toolkit**
- "fasterq-dump" version 2.10.9

Additionally, one script uses a conda environment, `joezone`. This can be reproduced using the `joezone.yml` file.

# Sources

data taken from :

Dixon, Gary, Heng Pan, Dapeng Yang, Bess P. Rosen, Therande Jashari, Nipun Verma, Julian Pulecio, et al. 2021. “QSER1 Protects DNA Methylation Valleys from de Novo Methylation.” Science 372 (6538). https://doi.org/10.1126/science.abd0875.

Excerpt from that paper's methods section

>Sequencing data was aligned to the hg19 reference genome using mem module from bwa-0.7.17 (58). Peak calling was performed by macs14 1.4.2 with default parameters except for histone modifications (59). Option --nomdel was used for histone modification peak calling as suggested (67). Normalized density was calculated using bamCompare module from deeptools 3.1.3 with --scaleFactorsMethod SES, --operation log2 and --ignoreDuplicates parameters (60). For histone ChIP-seq data sets, bam files of replicates (n=2) were merged together.

We want to recapitulate differential H3k27me3 deposition on Alkbh1 regulated genes, as shown in rice in :

Jia, Qingxiao, Xinran Zhang, Qian Liu, Junjie Li, Wentao Wang, Xuan Ma, Bo Zhu, et al. 2023. “A DNA Adenine Demethylase Impairs PRC2-Mediated Repression of Genes Marked by a Specific Chromatin Signature.” Genome Biology 24 (1): 198.

excerpt from that paper's methods section:
>ChIP-seq data analysis
> DNA from chromatin immunoprecipitation was used to construct sequencing libraries following the protocol provided by the Illumina TruSeq ChIP Sample Prep Set A and sequenced on Illumina HiSeq 2500. Trimmomatic (version 0.32) was used to filter out low-quality reads. Clean reads were mapped to the rice genome (MSU7.0; http://rice.plantbiology.msu.edu/) by Bowtie2 (version 2.4.2) using default parameters. SAMtools (version 1.9) was used to remove potential PCR duplicates. The bam files were first converted to Wiggle files, and bigwig files were generated using bamCoverage with the parameters “-bs 10 -normalizeUsing RPKM” in DeepTools [68], and the data were imported into the Integrated Genome Browser for visualization. The two replicates were merged using MACS2 in peak calling (version 2.1.1) [63], for H3K27me3 and ALKBH1 with the parameters “--broad --broad-cutoff 0.1”. The reads from input were used as controls for H3K27me3 and ALKBH1 ChIP-seq, respectively. The DiffBind (version 3.13) Bioconductor package [64] was used to find differential peaks between alkbh1 and WT samples. The DESeq2 method implemented in DiffBind was used to test the differential peaks. fold change > 1.5 and P-value < 0.05 were used to define differential binding peaks.

