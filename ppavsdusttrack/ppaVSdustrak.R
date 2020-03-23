setwd("~/AQdata/PurpleAir/NSS_vs_dustrak")
library(stringr)
library (plotly)

dustrak<-read.csv("01032020.csv")
dustrak$datetime<-paste0(dustrak$Date," ",dustrak$Time)
dustrak$datetime<-as.POSIXct(as.character(dustrak$datetime),format="%m/%d/%Y %H:%M:%OS",tz="")
dustrak$PM2.5<-dustrak$PM2.5*1000
dustrak %>%
  filter(PM2.5 < 100) -> dustrak
dataFiles<-list.files(path = "./data")
l<-list()
for (i in 1:length(dataFiles)){
  l[[i]]<-read.csv(paste0("./data/",dataFiles[i]))
}
dat<-as.data.frame(l[[1]])
for (i in 2:length(dataFiles)){
  dat<-rbind(dat,l[[i]])
}


dat$created_at<-as.POSIXct.POSIXlt(as.POSIXlt.character(as.character(dat$created_at),tz = "UTC"))
dat$PM2.5_CF1_ug.m3_2<-dat$PM2.5_CF1_ug.m3*1.5
p1 <- ggplot()+ 
  geom_line(data = dat, aes(x = created_at, y = `PM2.5_CF1_ug.m3_2`,color = "PurpleAir")) +
  geom_line(data = dustrak, aes(x = datetime, y = `PM2.5`, color = "Dustrak"))+
  xlab("")+
  ylab("PM2.5 ug/m3")+
  theme_minimal()+
  theme(legend.title = element_blank())
  

p1

ggplotly(p1)
chart_link = api_create(p1, filename = "public-graph",username = "anwargalshami", key = "w0DcOBMV5n31M5Y8hPZs")
chart_link
plot_ly()
