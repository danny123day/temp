data <- read.csv("Pagerank_0525.csv",head = T); data
data = as.matrix(data)

#機率矩陣
for( i in 1 : length(data[,1]) ){
  data[,i] = data[,i] / sum( data[,i] )
}
#Pr 矩陣
Pr = matrix(1 / length(data[,1]),nrow=5,ncol=1 ,byrow = F) ;Pr

d=0.3
for( i in 1:1){
  Pr = (1-d)/length(data[,1]) + d * ( data %*% Pr ) 
}

Pr

