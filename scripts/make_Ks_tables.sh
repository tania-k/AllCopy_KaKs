
grep -h -P '^MUNK01.*\s+MUNK01'  kaks/*.tab | cut -f4 > pairwise_ks/Hwer.tsv
grep -h -P '^CCFEE5311.*\s+CCFEE5311' kaks/*.tab | cut -f4 > pairwise_ks/Fendolithicus.tsv
grep -h -P '^NAJQ01.*\s+NAJQ01' kaks/*.tab | cut -f4  > pairwise_ks/Fsimplex.tsv
