install.packages("reshape2")
install.packages("Matrix")
library(reshape2)
library(Matrix)
#read file 
base <- read.delim("./ml-100k/u.data", header = FALSE)
colnames(base) <- c("userID","itemID","rating","timestamp")
class(base$rating)
base[,"rating"] <- as.numeric(base[,"rating"])
sum(duplicated(base[,1:2]))

#transfer to user-item matrix
## dcast : 將資料由較少變數鑄造成較多變數且較寬的資料(dataframe)
ratingDF <- dcast( base , userID ~ itemID ,value.var = "rating" ,index = "userID")
class(ratingDF)
ratingDF <- ratingDF[,2:ncol(ratingDF)]
ratingDF[is.na(ratingDF)] <- 0
ratingmatrix <- Matrix(as.matrix(ratingDF) , sparse = TRUE)
## cast data frame as matrix 轉成Sparse能降低佔用的空間(以10m的資料為例，原始的矩陣為5.6G, 經過sparse轉換後僅剩115m)

#cosine similarity between two vector
getCosine <- function(x,y){
  cosine <- sum(x*y) / (sqrt(sum(x,x))*sqrt(sum(y,y)))
  return(cosine)
}

#consine between every user 
getNeighbors <- function(x) {  # input a user id
  uuCosin <- sapply(seq(1:nrow(ratingmatrix)), 
                    function(y) cosine <- getCosine(ratingmatrix[x,], ratingmatrix[y,]))
  #print(uuCosin)
  y = order(uuCosin, decreasing = TRUE)[2:11]## first is self-Cosin, get Top-10 neibor
  #print(y)
  simXy = uuCosin[y] ## Top-10 similarity
  print(simXy)
  rbind(y,simXy)
}

#get rating of single y
getRating <- function(x,y,sim){
  meanY = sum(y)/sum(y>0)
  predict = (y - meanY)*sim
  return(predict)
}

#get rating of mean y
getRatings <- function(x,neighbor){
  ratings = 0
  for(i in 1 : ncol(neighbor)){
    y = ratingmatrix[neighbor[1,i],]
    sim = neighbor[2,i]
    ratings <- ratings + getRating(x,y,sim)
  }
  meanX = sum(x)/sum(x > 0)
  ratings = meanX + ratings/sum(neighbor[2,])
}

#compute RMSE 
getRMSE <- function(x,pred){
  sqrt(sum((x - t(pred))^2)/length(x))
}



index <- 1: nrow(ratingmatrix)

evaluation <- sapply(seq(1, 10), function(x){ ## input how many runs
  sampleData <- sample(index, 1)            ## input users per run
  startTime <- proc.time()
  pred <- sapply(sampleData, function(i){
    x = ratingmatrix[i,]
    neighbor = getNeighbors(i) ## 計算neighbor時間增加 n倍user
    print(neighbor)
    pred <- getRatings(x, neighbor)  
  }
  )
  endTime <- proc.time()-startTime
  result = rbind(time = endTime[1], RMSE = getRMSE(ratingmatrix[sampleData,], pred))
}
)
evaluation <- t(evaluation)
colnames(evaluation) <- c("time", "RMSE")
evaluation <- rbind(evaluation, mean = colMeans(evaluation))



