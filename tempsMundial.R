rm(list=ls())
setwd("C:/Users/Blasco/Desktop/WorldRowing DB")

categories <- c("lightweight-mens-single-sculls","lightweight-mens-double-sculls","lightweight-mens-quadruple-sculls",
                "mens-single-sculls","mens-pair","mens-double-sculls","mens-four", "mens-quadruple-sculls",
                "mens-eight","lightweight-womens-single-sculls","lightweight-womens-double-sculls",
                "lightweight-womens-quadruple-sculls","womens-single-sculls","womens-pair", "womens-double-sculls", "womens-four", "womens-quadruple-sculls", "womens-eight")

library(rvest)
library(stringr)
library(data.table) 

url <- "http://www.worldrowing.com/events/"

url2 <-"-world-rowing-championships/"

dfs<- list()
anys<-c(2014,2015,2017,2018,2019)
for (i in 1:length(anys)){
  Sys.sleep(10)
  any<-as.character(anys[i])
  url3<-paste0(url,any)
  url4<-paste0(url3,url2)
  dfs2<-list()
  for (j in 1:length(categories)){
    final.url<-paste0(url4,categories[j])
    page<-read_html(final.url)
    
    codi<- page %>%html_nodes('.table-body .boatCell') %>% html_text(trim = T)
    temps<-page %>%html_nodes('.table-body .timeCell') %>% html_text(trim = T)

      
    df<- data.frame(codi=codi,
                    temps=temps,
                    categoria=categories[j],
                    stringsAsFactors = F)
    df$temps <-as.numeric(substring(df$temps,1,2))*60 + as.numeric(substring(df$temps,4,5)) + as.numeric(substring(df$temps,7))/1000
    df$tempsdiferencia<-df$temps- df$temps[1]
    df$diferenciapercentatge<-df$tempsdiferencia/df$temps[1]
    df$Posicio <-0
    df$Any<- anys[i]
    df$Final<-NA
    for (m in 1:nrow(df)){
      if (m/6<1.001){
        df$Final[m]<-"A"
      }
      else if (m/6<2.001){
        df$Final[m]<-"B"
      }
      else if (m/6<3.001){
        df$Final[m]<-"C"
      }
      else if (m/6<4.001){
        df$Final[m]<-"D"
      }
      df$Posicio[m]<-m
    }
    dfs2[[j]]<-df
  } 
  dat<-as.data.frame(rbindlist(dfs2))
  dfs[[i]]<-dat
}
dades<-as.data.frame(rbindlist(dfs))

for (i in 1:nrow(dades)){
  if (dades$Any[i]==1){
    dades$Any[i]<-2014
  }
  else if (dades$Any[i]==2){
    dades$Any[i]<-2015
  }
  else if (dades$Any[i]==3){
    dades$Any[i]<-2017
  }
}

dades$Competicio <- "World Championships"

save(dades,file="WR.RData")

