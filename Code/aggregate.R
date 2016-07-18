#install.packages("plyr")
library(plyr)

#df<-read.table("/Users/rohanmurde/Documents/Rohan_Datasets/adni_afterImputation.csv", header = TRUE, sep = ",", row.names = NULL)
#df<-read.table("/Users/rohanmurde/Desktop/Capstone/Datasets/fromPEMM.csv", header = TRUE, sep = ",", row.names = NULL)
df<-read.table("/Users/rohanmurde/Desktop/Capstone/Datasets/adni_dataset3_fromPEMM_addedDX.csv", header = TRUE, sep = ",", row.names = NULL)

#Code to calculate mean of each column patient wise.
adas_mean <- aggregate(ADAS13 ~ RID, data = df, mean)
mmse_mean <- aggregate(MMSE ~ RID, data = df, mean)
cdmemory_mean <- aggregate(CDMEMORY ~ RID, data = df, mean)
ipca_mean <- aggregate(IPCA ~ RID, data = df, mean)
abeta_mean <- aggregate(ABETA ~ RID, data = df, mean)
tau_mean <- aggregate(TAU ~ RID, data = df, mean)
ptau_mean <- aggregate(PTAU ~ RID, data = df, mean)
ab40_mean <- aggregate(AB40 ~ RID, data = df, mean)
ab42_mean <- aggregate(AB42 ~ RID, data = df, mean)
CEREBELLUMGREYMATTER_mean <- aggregate(CEREBELLUMGREYMATTER ~ RID, data = df, mean)
brainstem_mean <- aggregate(BRAINSTEM ~ RID, data = df, mean)
WHOLECEREBELLUM_mean <- aggregate(WHOLECEREBELLUM ~ RID, data = df, mean)
frontal_mean <- aggregate(FRONTAL ~ RID, data=df,mean)
cingulate_mean<-aggregate(CINGULATE ~ RID, data=df,mean)
parietal_mean<-aggregate(PARIETAL ~ RID,data=df,mean)
temporal_mean<-aggregate(TEMPORAL~RID,data=df,mean)
SUMMARYSUVR_WHOLECEREBNORM_mean<-aggregate(SUMMARYSUVR_WHOLECEREBNORM ~ RID, data=df,mean)
bbsi_mean <-aggregate(BBSI ~ RID, data=df, mean)
dbcbbsi_mean <-aggregate(DBCBBSI ~ RID, data=df, mean)
vbsi_mean <- aggregate(VBSI ~ RID, data=df, mean)
brainvol_mean <- aggregate(BRAINVOL ~ RID, data = df, mean)
ventvol_mean <- aggregate(VENTVOL ~ RID, data = df, mean)

df <- join_all(list(adas_mean, mmse_mean, cdmemory_mean, ipca_mean, abeta_mean, tau_mean, ptau_mean, ab40_mean, ab42_mean, CEREBELLUMGREYMATTER_mean, brainstem_mean, WHOLECEREBELLUM_mean, frontal_mean, cingulate_mean, parietal_mean, temporal_mean, SUMMARYSUVR_WHOLECEREBNORM_mean, bbsi_mean, dbcbbsi_mean, vbsi_mean, brainvol_mean, ventvol_mean), by = 'RID', type = 'full')

#write.csv(df, file = "/Users/rohanmurde/Documents/Rohan_Datasets/fromPEMM_after_mean.csv")
write.csv(df, file = "/Users/rohanmurde/Desktop/Capstone/Datasets/fromPEMM_after_mean.csv")

#code to get the latest state of patient considering his last VISCODE(MONTH).
#df<-read.table("/Users/rohanmurde/Documents/Rohan_Datasets/adni_afterImputation.csv", header = TRUE, sep = ",", row.names = NULL)
df<-read.table("/Users/rohanmurde/Desktop/Capstone/Datasets/adni_dataset3_fromPEMM_addedDX.csv", header = TRUE, sep = ",", row.names = NULL)
temp = data.frame(unique(df$RID))

temp1<-data.frame()
temp2<-data.frame()
temp3<-data.frame()
for(j in temp$unique.df.RID.){
temp1 <- subset(df,RID == j,select=c(RID,Month,DX))
temp2 <- subset(temp1,Month == max(Month),select=c(RID,Month,DX))
temp3 <- rbind(temp2,temp3)
}
write.csv(temp3, file = "/Users/rohanmurde/Desktop/Capstone/Datasets/aggregate_temp.csv")


#Sort aggregate_temp.csv in ascending order of RID
#Add DX column to aggregate_temp.csv from 8036_trial.csv
#remove duplicate entries.
#To remove duplicates: click filters->advanced filter, select copy to another location, give another location under CopyTo: and check the Unique records only.
#save it.

#exp7_temp.csv has 2 records less than exp7_after_mean.csv
#RID = 4968,5200 are missing because they have months as NA.

#copy DX values till RID = 4966. Paste to exp7_after_mean.
#For RID = 4968 put DX=AD.
#copy DX values from RID = 4971 to 5199. Paste to exp7_after_mean.
#For RID = 5200 put DX=NL.
#copy DX values from RID = 5202 to 5296. Paste to exp7_after_mean.
