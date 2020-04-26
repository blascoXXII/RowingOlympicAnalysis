setwd("C:/Users/Blasco/Desktop/WorldRowing DB")
load("BaseDeDadesCompleta.RData")

dades <- TotalDades

library(stringr)
dades$Sexe<-NA
dades$Cat<-NA
dades$Pes<-NA
dades$Minuts<-NA
dades$Segons<-NA
dades$Mile<-NA

for (i in 1:nrow(dades)){
  if (str_detect(dades$categoria[i],"womens")==TRUE){
    dades$Sexe[i]<-"F"
  }
  else {
    dades$Sexe[i] <-"M"
  }
  
  if (str_detect(dades$categoria[i],"lightweight")==TRUE){
    dades$Pes[i]<- "LW"
  }
  else{
    dades$Pes[i]<-"OW"
  }
  
  if (str_detect(dades$categoria[i],"double")==TRUE){
    dades$Cat[i]<-"2x"
  }
  else if (str_detect(dades$categoria[i],"eight")==TRUE){
    dades$Cat[i]<-"8+"
  }
  else if (str_detect(dades$categoria[i],"four")==TRUE){
    dades$Cat[i]<-"4-"
  }
  else if (str_detect(dades$categoria[i],"pair")==TRUE){
    dades$Cat[i]<-"2-"
  }
  else if (str_detect(dades$categoria[i],"quadruple")==TRUE){
    dades$Cat[i]<-"4x"
  }
  else if (str_detect(dades$categoria[i],"single")==TRUE){
    dades$Cat[i]<-"1x"
  }
  
  
  t<-strsplit(dades$temps[i],"")[[1]]
  min<-t[1:2]
  seg<-t[4:5]
  mil<-t[7:9]
  min<-paste0(min[1],min[2])
  seg<-paste0(seg[1],seg[2])
  mil<-paste0(mil[1],mil[2],mil[3])
  min<-as.numeric(min)
  seg<-as.numeric(seg)
  mil<-as.numeric(mil)
  dades$Minuts[i]<-min
  dades$Segons[i]<-seg
  dades$Mile[i]<-mil
}

dades$Temps2<-NA

for (i in 1:nrow(dades)){
  t<-0
  t<-t+dades$Minuts[i]*60+dades$Segons[i]+dades$Mile[i]/1000
  dades$Temps2[i]<-t
}

save(dades,file="TotalDades2.RData")


 

