d.tree <- read.csv("data_0324.csv" , head = TRUE)
d <-names(d.tree)
attribute1_name = names(summary(as.factor(d.tree[,1])))
attribute2_name = names(summary(as.factor(d.tree[,2])))
attribute3_name = names(summary(as.factor(d.tree[,3])))
caculate_info <- function(attribute,attribute_type){
  class1 = 0
  class2 = 0
  count_attribute_type = 0
  if(!is.numeric(attribute_type)){
    for(i in 1 :nrow(d.tree)){
      if(d.tree[i,attribute] == attribute_type ){
        count_attribute_type = count_attribute_type + 1
        if(d.tree[i,4] == 1){
          class1 = class1 + 1
        }else if(d.tree[i,4] == 2){
          class2 = class2 + 1
        }
      } 
    }
  }
  temp1 = -class1 / count_attribute_type
  temp2 = -class2 / count_attribute_type
  log_temp1 = log2(-temp1)
  log_temp2 = log2(-temp2)
  if(temp1 == 0){
    log_temp1 = 0
  }
  if(temp2 == 0){
    log_temp2 = 0
  }
  info_sum = count_attribute_type / nrow(d.tree) * (temp1 *  log_temp1+ temp2 * log_temp2)
  
  return(info_sum)
}
caculate_info_Int <- function(attribute,attribute_type){
  class1_greater = 0
  class2_greater = 0
  count_attribute_type_greater = 0
  class1_less = 0
  class2_less = 0
  count_attribute_type_less = 0
  if(is.numeric(attribute_type)){
    for(i in 1 :nrow(d.tree)){
      if(d.tree[i,attribute] >= attribute_type ){
        count_attribute_type_greater = count_attribute_type_greater + 1
        if(d.tree[i,4] == 1){
          class1_greater = class1_greater + 1
        }else if(d.tree[i,4] == 2){
          class2_greater = class2_greater + 1
        }
      }else{
        count_attribute_type_less = count_attribute_type_less + 1
        if(d.tree[i,4] == 1){
          class1_less = class1_less + 1
        }else if(d.tree[i,4] == 2){
          class2_less = class2_less + 1
        }
      }
    }
  }
  temp1_G = -class1_greater / count_attribute_type_greater
  temp2_G = -class2_greater / count_attribute_type_greater
  log_temp1_G = log2(-temp1_G)
  log_temp2_G = log2(-temp2_G)
  if(temp1_G == 0){
    log_temp1_G = 0
  }
  if(temp2_G == 0){
    log_temp2_G = 0
  }
  info_sum_greater = count_attribute_type_greater / nrow(d.tree) * (temp1_G *  log_temp1_G + temp2_G * log_temp2_G)
  temp1_L = -class1_less / count_attribute_type_less
  temp2_L = -class2_less / count_attribute_type_less
  log_temp1_L = log2(-temp1_L)
  log_temp2_L = log2(-temp2_L)
  if(temp1_L == 0) log_temp1_L = 0
  if(temp2_L == 0) log_temp2_L = 0
  info_sum_less = count_attribute_type_less / nrow(d.tree) * (temp1_L * log_temp1_L + temp2_L * log_temp2_L)
  info_sum = info_sum_greater + info_sum_less
  return(info_sum)
  
}
info_A1 = 0
for(i in 1:length(attribute1_name)){
  info_A1 = info_A1 + caculate_info(1,attribute1_name[i])
}


info_A2 = 0
#for(i in 1:length(attribute2_name)){
  info_A2 = info_A2 + caculate_info_Int(2,80)
  
#}

info_A3 = 0
for(i in 1:length(attribute3_name)){
  info_A3 = info_A3 + caculate_info(3,attribute3_name[i])
}

gain_A1 = 0.94 - info_A1
gain_A2 = 0.94 - info_A2
gain_A3 = 0.94 - info_A3

cat(gain_A1)
cat(gain_A2)
cat(gain_A3)

install.packages("C50")
library(C50)
model <- C5.0(class~. ,data =  d.tree,rules = TRUE)
