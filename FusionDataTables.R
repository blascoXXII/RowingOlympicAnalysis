rm(list=ls())
setwd("C:/Users/Blasco/Desktop/WorldRowing DB")

load("WR.RData")
WR<- dades

load("CopesMon.RData")
Copes<-dades
rm(dades)

TotalDades<-rbind(WR, Copes)

save(TotalDades, file="BaseDeDadesCompleta.RData")