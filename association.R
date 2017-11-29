data <- c("ACD","BCE","ABCE","BE")
count = matrix(0, nrow = 5)
class = c("A","B","C","D","E")
for( i in 1 : length(data)){
  for(j in 1:length(class)){
     if(grepl( class[j],data[i])){
       count[j] = count[j] + 1
     }
  }
}

class = class[-which(count < 2)]
class = combn(class, 2)

count = matrix(0, nrow = ncol(class))
for( i in 1 : length(data)){
  for(j in 1 : ncol(class)){
    if(grepl(class[1,j],data[i])){
        if(grepl(class[2,j],data[i])){
          count[j] = count[j] + 1
        }
    }
  }
}

class = class[,-which(count < 2)]
class = names(table(class))
class = combn(class, 3)

