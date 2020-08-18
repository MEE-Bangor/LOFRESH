#!/bin/perl


unless ($#ARGV == 0)

{

   print "Usage: 2_cutadapt_WP1_CO1.pl FastqList_WP1_18S\n";

die;
}


open (INLIST, "<$ARGV[0]") || die;


$indir = "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding/";
$outdir = "/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_CO1/";


while (<INLIST>) {
$lib = $_;
chomp($lib);

$read1 = $lib . "_1.fq.gz";
$read2 = $lib . "_2.fq.gz";

$cutout1 = $lib . "_cutout.1.fastq.gz";
$cutout2 = $lib . "_cutout.2.fastq.gz";


# use Trimmomatic to clip adaptor sequences & trim low-quality bases
system("cutadapt -g GGNACNGGNTGAACNGTNTANCCNCC -a TANACNTCNGGNTGNCCNAANAANCA --discard-untrimmed -o $outdir/$cutout1 -p $outdir/$cutout2 $indir/$read1 $indir/$read2");


}