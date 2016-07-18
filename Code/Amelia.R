dd_forAmelia <-read.table("/Users/rohanmurde/Desktop/Capstone/Datasets/adni_dataset2_removeRowsWithNA.csv", header = TRUE, sep = ",", row.names = NULL)

# a.out <- amelia(x=dd_forAmelia, m = 5, id="DX", idvars = "Month", autopri = 0.5)

a.out <- amelia(x=dd_forAmelia, m = 5, idvars = "DX", autopri = 0.5)
summary(a.out)
plot(a.out)
write.amelia(obj=a.out,file.stem="outdata")

for(j in 1:8036){
  dd_forAmelia[j,3:24] <- colMeans(rbind(a.out$imputations[[1]][j,3:24], 
                                         a.out$imputations[[2]][j,3:24], 
                                         a.out$imputations[[3]][j,3:24], 
                                         a.out$imputations[[4]][j,3:24], 
                                         a.out$imputations[[5]][j,3:24]) )
}
write.csv(dd_forAmelia, file = "/Users/rohanmurde/Desktop/Capstone/Datasets/adni_dataset3_afterAmeliaImputation4.csv")
