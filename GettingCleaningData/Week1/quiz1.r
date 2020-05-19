library(dplyr)
library(data.table)
getwd()
setwd("C:/R/0_courses/JHU_DataScience/GettingCleaningData/Week1")
FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

if (!file.exists("data")) dir.create("data")
if (!file.exists("./data/UScommunities.csv")) {
    download.file(FileUrl, destfile = "./data/UScommunities.csv")    
}


df_usc <- read.table("./data/UScommunities.csv", header = T, sep = ",")
df_usc %>%
    filter(VAL == 24) %>%
    summarise(n = n())

dt_usc <- fread("./data/UScommunities.csv", header = T, sep = ",")
dt_usc[, .N, by="VAL"][VAL == "24"]

FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
FileUrl <- "http://catalog.data.gov/dataset/natural-gas-acquisition-program"
if (!file.exists("./data/gov_NGAP.xlsx")) {
    download.file(FileUrl, destfile = "./data/gov_NGAP.xlsx")    
}

library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/getdata_data_DATA.gov_NGAP.xlsx", 
                         sheetIndex = 1, 
                         header = T,
                         rowIndex = rowIndex,
                         colIndex = colIndex
                         )
sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
FileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(FileUrl, useInternalNodes = TRUE)
rootNote <- xmlRoot(doc)
zipcode <- xpathSApply(doc = rootNote,"//zipcode",xmlValue)
length(zipcode[zipcode == 21231])

FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
if (!file.exists("./data/Fss06pid.csv")) {
    download.file(FileUrl, destfile = "./data/Fss06pid.csv")    
}


DT <- fread("./data/Fss06pid.csv", header = T, sep = ",")
Rprof()
m <- mean(DT$pwgtp15,by=DT$SEX)




Rprof(NULL)
s <- summaryRprof()
s$by.self

system.time(replicate(10000, mean(DT$pwgtp15,by=DT$SEX)))

system.time(replicate(10000, mean(DT[DT$SEX==1,]$pwgtp15),
                 mean(DT[DT$SEX==2,]$pwgtp15)))

system.time(replicate(10000, tapply(DT$pwgtp15,DT$SEX,mean)))

system.time(replicate(10000, sapply(split(DT$pwgtp15,DT$SEX),mean)))

system.time(replicate(10000, DT[,mean(pwgtp15),by=SEX]))                 

system.time(rowMeans(DT)[DT$SEX==1],
            rowMeans(DT)[DT$SEX==2])
            