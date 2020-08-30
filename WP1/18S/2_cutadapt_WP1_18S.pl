#!/bin/perl


unless ($#ARGV == 0)

{

   print "Usage: 2_cutadapt_WP1_18S.pl FastqList_WP1_18S\n";

die;
}


open (INLIST, "<$ARGV[0]") || die;


$indir = "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding/";
$outdir = "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_18S/";


while (<INLIST>) {
$lib = $_;
chomp($lib);

$read1 = $lib . "_1.fq.gz";
$read2 = $lib . "_2.fq.gz";

$cutout1 = $lib . "_cutout18S.1.fastq.gz";
$cutout2 = $lib . "_cutout18S.2.fastq.gz";


# use Trimmomatic to clip adaptor sequences & trim low-quality bases
system("cutadapt -g CCAGCAGCCGCGGTAATTCC -a ACTTTCGTTCTTGATCAA -e=0.2 --discard-untrimmed -o $outdir/$cutout1 -p $outdir/$cutout2 $indir/$read1 $indir/$read2");


}