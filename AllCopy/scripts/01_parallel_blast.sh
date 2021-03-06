#!/bin/bash
#SBATCH  --time 1-0:00:00 --ntasks 8 --nodes 1 --mem 2gb -p short --out logs/fasta.v1.%a.log -J parBLAST

module load ncbi-blast/2.2.30+
module load parallel

CPU=1
if [ $SLURM_CPUS_ON_NODE ] ; then
    CPU=$SLURM_CPUS_ON_NODE
fi


INFILE=AllCopy.txt
N=${SLURM_ARRAY_TASK_ID}
INDIR=seqIDs
OUT=results

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
    FILE=$INDIR/$NAME.fa.seqID.cleaned
    echo $FILE
    if [ ! -f $OUT/$NAME.CDS.fa ]; then
        parllel -j $CPU blastdbcmd -entry_batch {} -db Dothid ::: $FILE >> $OUT/$NAME.CDS.fa
    fi
done
