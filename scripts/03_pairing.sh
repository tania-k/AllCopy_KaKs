#!/usr/bin/bash
#SBATCH -N 1 -n 8 --mem 2gb -p short --out logs/makepairs.%a.log -J makepairs


CPUS=$SLURM_CPUS_ON_NODE
if [ -z $CPUS ]; then
	CPUS=1
fi

PEP=Aligned_PEP
CDS=results
Al_CDS=Aligned_CDS
INFILE=Orthogroups_nofa_2.tsv
N=${SLURM_ARRAY_TASK_ID}

if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "need to provide a number by --array or cmdline"
        exit
    fi
fi

IFS=,
sed -n ${N}p $INFILE | while read NAME
do
    FILE=$PEP/$NAME.fa.clean.cleaned
    echo $FILE
    if [ ! -f $Al_CDS/$NAME.cds.aln ]; then
        ./scripts/bp_mrtrans.pl -i $FILE -if fasta -s $CDS/$NAME.CDS.fa.cleaned.new -of fasta -o $Al_CDS/$NAME.cds.aln
    fi
done
