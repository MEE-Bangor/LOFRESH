library("Rcpp")
library("rlang")
library(dada2); packageVersion("dada2")
#library("phyloseq")

miseq_path <- "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_18S"

files_in_comp1<-list.files(miseq_path)
#write.table(files_in_comp1,"files_in_comp1.txt")

setwd(miseq_path)

fnFs <- sort(list.files(miseq_path,pattern="_cutout.1.fastq.gz"))
fnRs <- sort(list.files(miseq_path,pattern="_cutout.2.fastq.gz"))

sampleNames <- sapply(strsplit(basename(fnFs), "_cutout"), `[`, 1)
head(sampleNames)

fnFs <- file.path(miseq_path, fnFs)
fnRs <- file.path(miseq_path, fnRs)
#fnFs[1:3]

filt_path <- "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_18S/filtered"
if(!file_test("-d", filt_path)) dir.create(filt_path)

filtFs <- file.path(filt_path, paste0(sampleNames, "_F_filt.fastq.gz"))
filtRs <- file.path(filt_path, paste0(sampleNames, "_R_filt.fastq.gz"))

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(220,220),
                 maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                 compress=TRUE, multithread=TRUE, verbose=TRUE)
					 
#head_out<-head(out)
#write.table(head_out,"head_out_data_purified_comp_1.txt")


derepFs <- derepFastq(filtFs, verbose=TRUE)
derepRs <- derepFastq(filtRs, verbose=TRUE)
names(derepFs) <- sampleNames
names(derepRs) <- sampleNames

errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)

#pdf("rplot_purified_comp_1.pdf")
#plotErrors(errF)
#plotErrors(errR)
#dev.off()

dadaFs <- dada(derepFs, err=errF, multithread=TRUE)
dadaRs <- dada(derepRs, err=errR, multithread=TRUE)
dada_inspect_seq_var<-dadaFs[[1]]
#write.table(dada_inspect_seq_var,"dada_inspect_seq_var.txt")				 

mergers <- mergePairs(dadaFs, derepFs, dadaRs, derepRs)
head_mergers<-head(mergers[[1]])
write.table(head_mergers,"head_mergers.txt")

seqtabAll <- makeSequenceTable(mergers[!grepl("Mock", names(mergers))])
seq_lengths<-table(nchar(getSequences(seqtabAll)))
write.table(seq_lengths,"seq_lengths.txt")					 

seqtabNoC <- removeBimeraDenovo(seqtabAll)

getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtabNoC))
# If processing a single sample, remove the sapply calls: e.g. replace sapply(dadaFs, getN) with getN(dadaFs)
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sampleNames
write.table(track,"track.txt")

fastaRef <- "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/silva_132.18s.99_rep_set.dada2.fa.gz"
taxTab <- assignTaxonomy(seqtabNoC, refFasta = fastaRef, multithread=TRUE)

write.table(taxTab,"taxTab_WP1_18S.txt")				 
write.table(seqtabNoC,"seqtabNoC_WP1_18S.txt")

samples.out <- rownames(seqtabNoC)
write.table(samples.out,"samples.out_WP1_18S.txt")


