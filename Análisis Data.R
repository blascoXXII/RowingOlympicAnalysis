rm(list=ls())
setwd("C:/Users/Blasco/Desktop/WorldRowing DB")
load("BaseDeDadesCompleta.RData")

library(ggplot2)
library(gganimate)
library(gapminder)

#Dataframe with category, year and final means

MitjanesCategoria <- aggregate(TotalDades[,c(2,4,5)],list(TotalDades$categoria,TotalDades$Any,TotalDades$Final), mean)
MitjanesCategoria$Sexe <- 0

for (i in 1:nrow(MitjanesCategoria)){
  if (grepl("women",MitjanesCategoria$Group.1[i])) {
    MitjanesCategoria$Sexe[i] <- "D"
  } else {
    MitjanesCategoria$Sexe[i] <- "H"
  }
}

MitjanesCategoria <- MitjanesCategoria[MitjanesCategoria$Group.3=="A",]
MitjanesCategoria<- MitjanesCategoria[MitjanesCategoria$tempsdiferencia>=0,]
MitjanesCategoria <- MitjanesCategoria[MitjanesCategoria$diferenciapercentatge<=5,]

#Boxplot (Homes - Dones)

MitjanesCategoria$diferenciapercentatge <- MitjanesCategoria$diferenciapercentatge *100

boxplot(MitjanesCategoria$diferenciapercentatge ~MitjanesCategoria$Sexe, title("Boxplot by gender"))
boxplot(MitjanesCategoria$diferenciapercentatge ~MitjanesCategoria$Group.1)

# Dot Plot (By Category)

ggplot(TotalDades, aes(x=))
