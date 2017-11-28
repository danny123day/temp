file = read.csv(file = "Temp.csv" , header = FALSE)
library(dplyr)
library(tidyr)
options(stringsAsFactors = FALSE)
#取公司名
company_code_text = as.matrix(file[1,])
company_code_text = t(company_code_text)
company_code_text = as.data.frame(company_code_text)

company_code_text %>%
   separate(col= "1", sep = "-", into = c("Companys","V1","V2","V3"), convert=TRUE) -> company_code_text
#Delete "#NAME?"
company_code_text = company_code_text[-1,]
company_code_text[is.na(company_code_text)] = ""


# company unique & delete "#ERROR"
company_name = as.matrix(unique(company_code_text[,1]))
company_name = company_name[-(which(company_name == "#ERROR")),1]

#Variable name
for(i in 1:length(company_code_text[,2])){
  company_code_text[i,2] = paste(company_code_text[i,2:length(company_code_text[1,])],collapse = "-")
}



#取年份
Year = as.vector(file[2:length(file[,1]),1]) ;Year
Year = rep(Year,length(company_name)) ;Year

#貼上公司名稱和年份
#length(file[,1]) = 28
company_length = length(file[,1])-1 ;company_length

company_name_final = vector(mode = "character",length = length(Year))
for(i in 1:length(Year)){
  if((i %% company_length )==1)
    company_name_final[i] = company_name[i/company_length +1]
  else
    company_name_final[i] = " "
  
}
output_file = data.frame(company_name_final,Year)
options(stringsAsFactors = FALSE)

#貼上

for(i in 2:length(file[1,]) ){
  if(file[1,i] != "#ERROR"){
    output_file[((1+company_length*(which(company_code_text[(i-1),1] == company_name)-1)):(company_length+company_length*(which(company_code_text[(i-1),1] == company_name)-1))),company_code_text[(i-1),2]] = file[2:length(file[,1]),i]
  }
}

write.csv(output_file,"table14.csv")
