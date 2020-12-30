#library(ggplot2)
#library(dplyr)
#plotHist(filein)
pdf("Ks_plots.pdf")
for (d in list.files(path = ".",pattern="*.tsv")) {
 print(d)
 n=read.table(d,header=T)
 n = subset(n,n$dS <= 1) # rmeove large values not useful estimates
 hist(n$dS,100,main=sprintf("dS for %s",d))
}

