setwd("C:/Users/user/Desktop/project")
file <- read.csv(file = "gender-twitter.csv",header = T)
#install.packages("stringr", dependencies = TRUE)

library(stringr)
file$description <- tolower(file$description)

file$description[29]
head(file$description)
file$description <- tolower(file$description)
file$description <- stringr::str_replace_all(file$description,"[:).,(!@#$|?&-]", " ")

file$description[29]

#transfrom to corpus
#human install.packages("tm")

library(tm)
male_words <- paste(file$description[file$gender == "male" | file$gender == "female"] , collapse = " ")
male_source <- VectorSource(male_words)
male_corpus <- Corpus(male_source)
#nonhuman
brand_words <- paste(file$description[file$gender == "brand"] , collapse = " ")
brand_source <- VectorSource(brand_words)
brand_corpus <- Corpus(brand_source)

#---cleaning
#human
male_corpus <- tm_map(male_corpus, removePunctuation)
male_corpus <- tm_map(male_corpus, stripWhitespace)
male_corpus <- tm_map(male_corpus, removeWords , stopwords("english"))
#nonhuman
brand_corpus <- tm_map(brand_corpus, removePunctuation)
brand_corpus <- tm_map(brand_corpus, stripWhitespace)
brand_corpus <- tm_map(brand_corpus, removeWords , stopwords("english"))

#Making document-term matrix
dtm_m <- DocumentTermMatrix(male_corpus)
dtm2_m <- as.matrix(dtm_m)
male_freqwords <- colSums(dtm2_m)
male_freqwords <- sort(male_freqwords,decreasing = TRUE)
head(male_freqwords,20)

dtm_b <- DocumentTermMatrix(brand_corpus)
dtm2_b <- as.matrix(dtm_b)
brand_freqwords <- colSums(dtm2_b)
brand_freqwords <- sort(brand_freqwords,decreasing = TRUE)
head(brand_freqwords,20)


#word cloud 
#install.packages("wordcloud")
library(wordcloud)
words_h <- names(male_freqwords)
wordcloud(words_h[1:100],male_freqwords[1:100],random.order = FALSE,col = male_freqwords[1:5])
words_b <- names(brand_freqwords)
wordcloud(words_b[1:100],brand_freqwords[1:100],random.order = FALSE,col = male_freqwords[1:5])
class(words_h)
class(male_freqwords)
#frequency - barchart
#install.packages("ggplot2")
library(ggplot2)
class(male_freqwords)
ggplot(male_freqwords[1:10] , aes(x = names(male_freqwords[1:10]) , y = male_freqwords[1:10])) + geom_line()

#cleaning brand frequent words
brand_freqwords_feature <- names(brand_freqwords)[1:10]
human_freqwords_feature <- names(male_freqwords)[1:10]
brand_freqwords_feature <- brand_freqwords_feature[-c(1,4,10)]
brand_freqwords_feature

#Testing (correct-ratio)
Number_of_correct = 0
Number_of_wrong = 0
for(i in 1 : nrow(file)){
  if(sum(sapply(brand_freqwords_feature, grepl, file$description[i]))>0 & file$gender[i] == "brand"){
     Number_of_correct = Number_of_correct + 1
  }else if(sum(sapply(brand_freqwords_feature, grepl, file$description[i]))==0 & file$gender[i] != "brand"){
     Number_of_correct = Number_of_correct + 1
  }else{
     Number_of_wrong = Number_of_wrong + 1
  }
}
Number_of_correct 
Number_of_wrong 
cat("Correct ratio : ",Number_of_correct/(Number_of_correct + Number_of_wrong)," %")



#cleaning the gender_confidence
#brand_freqwords_feature <- brand_six_freqword[-2]

for(i in 1 : nrow(file)){
  if(is.na(as.integer(as.character(file$gender_confidence[i]))))
    file$gender_confidence[i] = 1
}
for(i in 1 : nrow(file)){
  if(file$gender[i] == "unknown" | as.integer(as.character(file$gender_confidence[i])) < 0.6){
         if(sum(sapply(brand_freqwords_feature, grepl, file$description[i]))>0){
            file$brand_ratio[i] = 1
         }else{
            file$brand_ratio[i] = 0
         }
  }else{
    file$brand_ratio[i] = 0
  }

}
count = 0
for(i in 1 : nrow(file)){
  if(file$brand_ratio[i] == 1){
      print(as.character(file$name[i]))
      count = count + 1
  }
}
count

##########------------------
file$description[109]
as.integer(as.character(file$gender_confidence[55]))
for(i in 1 : nrow(file)){
  if(is.na(as.integer(as.character(file$gender_confidence[i]))))
    file$gender_confidence[i] = 1
}
sum(sapply(brand_freqwords_feature, grepl, file$description[109])) >0
file$gender[110] == "unknown" | as.integer(as.character(file$gender_confidence[110])) < 0.6
sum(sapply(brand_freqwords_feature, grepl, file$description[110])) >0
count = 0
for(i in 1 : nrow(file)){
  if(file$gender[i] == "male" & as.integer(file$retweet_count[i]) == 1)
    count = count + 1
}
