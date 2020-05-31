
getwd()
setwd("C:/R/0_courses/JHU_DataScience/GettingCleaningData/Week2")

if (!file.exists("data")) {
    dir.create("data")
}

FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(FileUrl, destfile = "./data/usCommunities.csv")

usCommunities <- read.csv("./data/usCommunities.csv")

unique(usCommunities$ACR) #3
unique(usCommunities$AGS) #6

str(usCommunities$AGS)

which(usCommunities$ACR == 3 & usCommunities$AGS == 6)


install.packages("jpeg")
library(jpeg)
library(dplyr)



FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(FileUrl, destfile = "./data/picture.jpg", mode = "wb")

j <- readJPEG(source = "./data/picture.jpg", native = T)
quantile(j,0.3)
quantile(j,0.8)


FileUrl_FGDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
FileUrl_FEDSTATS <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(FileUrl_FGDP, destfile = "./data/FGDP.csv")
download.file(FileUrl_FEDSTATS, destfile = "./data/FEDSTATS.csv")

FGDP <- read.csv("./data/FGDP.csv",skip = 4)
FGDP$X.4 <- as.character(FGDP$X.4)
FGDP$X.4 <- as.numeric(
    gsub(",","",
         gsub(" ","",
              FGDP$X.4)))

FGDP$X.1 <- as.numeric(
    gsub(",","",
         gsub(" ","",
              FGDP$X.1)))

FGDP <- FGDP %>%
    filter(!is.na(X)) %>%
    filter(!is.na(X.1))

FEDSTATS <- read.csv("./data/FEDSTATS.csv")

fcom <- merge(FGDP,FEDSTATS, by.x = "X", by.y = "CountryCode", all = F)
View(fcom[order(fcom$X.4),])

tapply(fcom$X.1,fcom$Income.Group,mean)

fcom$rank_groups <- cut(fcom$X.4,breaks = quantile(fcom$X.4,c(0.0,0.2,0.4,0.6,0.8,1)))
table(fcom$rank_groups,fcom$Income.Group)









