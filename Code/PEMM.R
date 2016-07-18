dd_forAmelia <-read.table("/Users/rohanmurde/Desktop/Capstone/Datasets/adni_dataset2_removeRowsWithNA.csv", header = TRUE, sep = ",", row.names = NULL)
dd_forAmelia$DX <- NULL
PEM.result = PEMM_fun(data.matrix(dd_forAmelia), phi=0)
write.csv(PEM.result$Xhat, file = "/Users/rohanmurde/Desktop/Capstone/Datasets/adni_dataset3_fromPEMM.csv")
