data <- read.csv(file = "test.csv")
class(data)
data$datatime = strptime(paste(data$date,data$time),format = "%Y-%m-%d %H:%M")
now_date = strptime(Sys.time(),format = "%Y-%m-%d %H:%M:%S")
data$difftime = as.numeric(difftime(now_date,data$datatime,units = "hours"))
#補值
sales_mean <- mean(data$SALE_AMT[!is.na(data$SALE_AMT)])
data$SALE_AMT[is.na(data$SALE_AMT)] <- sales_mean

for(i in 1:nrow(data)){
    if(is.na(data[i,"CCARID"])){
      if(data[i,"MEMNO"] != ""){
          data[i,"CCARID"] =   data[i,"MEMNO"]
    }
  }
}
data <- data[complete.cases(data[,"CCARID"]),]
data_final = data[,c("CCARID","SALE_AMT","difftime")]
data_final = data_final[order(data_final$CCARID,data_final$difftime,decreasing=FALSE),]
id_class <- unique(data_final$CCARID) 

r <- numeric(0)
f <- numeric(0)
m <- numeric(0)
for(i in 1:length(id_class)){
    r = c( r , data_final$difftime[data_final$CCARID == id_class[i]][1] )  
}
f_count = 1
for(i in 1:nrow(data_final)){
    if(data_final$CCARID[i] == data_final$CCARID[i+1] & i != nrow(data_final)){
        if(data_final$difftime[i] != data_final$difftime[i+1]){
            f_count = f_count + 1
        }
    }else {
        f = c(f , f_count)
        f_count = 1
    }
    
}
for(i in 1:length(r)){
    m = c( m , sum(data_final$SALE_AMT[r[i] == data_final$difftime]))        
}

#combine r,f,m
RFM.df = data.frame(ID = id_class , R = r , F = f , M = m)


mean_R = mean(RFM.df$R)
mean_F = mean(RFM.df$F)
mean_M = mean(RFM.df$M)

#RFM algorthm
for(i in 1:nrow(RFM.df)){
  #VIP group1 RFM
  if(RFM.df[i,"F"] >= mean_F & RFM.df[i,"R"] >= mean_R & RFM.df[i,"M"] >= mean_M){
    RFM.df$group[i] = 1
  }else if(RFM.df[i,"F"] >= mean_F & RFM.df[i,"R"] < mean_R & RFM.df[i,"M"] >= mean_M){
    RFM.df$group[i] = 2
    #F M
  }else if(RFM.df[i,"F"] >= mean_F & RFM.df[i,"R"] >= mean_R & RFM.df[i,"M"] < mean_M){
    RFM.df$group[i] = 3
    #R F
  }else if(RFM.df[i,"F"] < mean_F & RFM.df[i,"R"] >= mean_R & RFM.df[i,"M"] >= mean_M){
    RFM.df$group[i] = 4
    #R M
  }else if(RFM.df[i,"F"] >= mean_F & RFM.df[i,"R"] < mean_R & RFM.df[i,"M"] < mean_M){
    RFM.df$group[i] = 5
    #F 
  }else if(RFM.df[i,"F"] < mean_F & RFM.df[i,"R"] >= mean_R & RFM.df[i,"M"] < mean_M){
    RFM.df$group[i] = 6
    #R
  }else if(RFM.df[i,"F"] < mean_F & RFM.df[i,"R"] < mean_R & RFM.df[i,"M"] >= mean_M){
    RFM.df$group[i] = 7
    #M
  }else if(RFM.df[i,"F"] < mean_F & RFM.df[i,"R"] < mean_R & RFM.df[i,"M"] < mean_M){
    RFM.df$group[i] = 8
    #
  }
}

#pie chart
lbls <- c("Group1","Group2","Group3","Group4","Group5","Group6","Group7","Group8")
pct <- prop.table(table(RFM.df$group))
lbls <- paste(lbls, "-",round(pct,2)*100) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(table(RFM.df$group),labels = lbls, col=rainbow(length(lbls)),
    main="Rank Distribution"
)

#3D plot
library(plot3D)
scatter3D(x = RFM.df$F , xlab = "Fequency" , y = RFM.df$R ,ylab = "Recent",z = RFM.df$M ,zlab = "Money", theta = -40, phi = 10, bty = "b2" , colvar = RFM.df$group )

#rotate the 3D plot
install.packages("plot3Drgl")
library(plot3Drgl)
plotrgl()

