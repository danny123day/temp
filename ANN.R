require(neuralnet)
require(nnet)
require(caret) 
data <- iris
head(class.ind(data$Species))
data <- cbind(data, class.ind(data$Species))
head(data)
formula.bpn <- setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
bpn <- neuralnet(formula = formula.bpn, 
                 data = data,
                 hidden = c(2),       # 一個隱藏層：2個node
                 learningrate = 0.01, # learning rate
                 threshold = 0.1,    # partial derivatives of the error function, a stopping criteria
                 stepmax = 5e5        # 最大的ieration數 = 500000(5*10^5)
                 
)

# bpn模型會長得像這樣
plot(bpn)

smp.size <- floor(0.8*nrow(data)) 
set.seed(131)  
train.ind <- sample(seq_len(nrow(data)), smp.size)
train <- data[train.ind, ]
test <- data[-train.ind, ]

model <- train(form=formula.bpn,     # formula
               data=train,           # 資料
               method="neuralnet",   # 類神經網路(bpn)
               
               # 最重要的步驟：觀察不同排列組合(第一層1~4個nodes ; 第二層0~4個nodes)
               # 看何種排列組合(多少隱藏層、每層多少個node)，會有最小的RMSE
               tuneGrid = expand.grid(.layer1=c(1:4), .layer2=c(0:4), .layer3=c(0:4)),               
               
               # 以下的參數設定，和上面的neuralnet內一樣
               learningrate = 0.01,  # learning rate
               threshold = 0.01,     # partial derivatives of the error function, a stopping criteria
               stepmax = 5e5         # 最大的ieration數 = 500000(5*10^5)
)

# 會告訴你最佳的參數組合是什麼：第一隱藏層1個node，第二隱藏層2個node
model
plot(model)
bpn <- neuralnet(formula = formula.bpn, 
                 data = train,
                 hidden = c(1,1,3),     # 第一隱藏層1個node，第二隱藏層2個nodes
                 learningrate = 0.01, # learning rate
                 threshold = 0.01,    # partial derivatives of the error function, a stopping criteria
                 stepmax = 5e5        # 最大的ieration數 = 500000(5*10^5)
                 
)

# 新的bpn模型會長得像這樣
plot(bpn)
pred <- compute(bpn, test[, 1:4])  

# 預測結果
pred$net.result
pred.result <- round(pred$net.result)
pred.result
pred.result <- as.data.frame(pred.result)
# 建立一個新欄位，叫做Species
pred.result$Species <- ""

# 把預測結果轉回Species的型態
for(i in 1:nrow(pred.result)){
  if(pred.result[i, 1]==1){ pred.result[i, "Species"] <- "setosa"}
  if(pred.result[i, 2]==1){ pred.result[i, "Species"] <- "versicolor"}
  if(pred.result[i, 3]==1){ pred.result[i, "Species"] <- "virginica"}
}

pred.result
table(real    = test$Species, 
      predict = pred.result$Species)
