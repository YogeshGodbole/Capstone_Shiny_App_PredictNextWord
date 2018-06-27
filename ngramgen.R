library(RWekajars)
library(ggplot2)
library(RColorBrewer)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava)
library(tidyr)

dir <- "C:/Users/yogesh.godbole/Documents/Yogesh/Data Science/Course5/final/en_US/"
enblogs <- readLines(paste(dir,"en_US.blogs.txt",sep=""))
ennews <- readLines(paste(dir,"en_US.news.txt",sep=""))
entwitter <- readLines(paste(dir,"en_US.twitter.txt",sep=""))
if (!file.exists(paste(dir,"badwords.txt",sep="")))
{download.file(url=badwordurl, destfile=paste(dir,"badwords.txt",sep=""))}
profanity <- readLines(paste(dir,"badwords.txt",sep=""))

#Loading the R Text Mining Pakcage
library(tm)
linestoread <- 5000
enblogs <-sample(enblogs, linestoread, replace=FALSE)
ennews <-sample(ennews, linestoread, replace=FALSE)
entwitter <-sample(entwitter, linestoread, replace=FALSE)
en_all <- c(enblogs,ennews,entwitter)
en_all <- gsub("[^a-zA-Z0-9 ]","",en_all)
en_all <- removeNumbers(en_all)
en_all <- removePunctuation(en_all)
en_all <- stripWhitespace(en_all)
en_all <- tolower(en_all)
en_all <-removeWords(en_all,profanity)
en_all <- data.frame(en_all,stringsAsFactors = FALSE)




#Creating a courpus from the character vector. This will be used by the text mining package to clean and tockenize data
finalCorpus<-VCorpus(VectorSource(en_all))



#Loading tockenizers package
library(tokenizers)

finalCorpusDF <-data.frame(text=unlist(sapply(finalCorpus,`[`, "content")), 
                           stringsAsFactors = FALSE)

## Building the tokenization function for the n-grams
ngramTokenizer <- function(theCorpus, ngramCount) {
  ngramFunction <- RWeka::NGramTokenizer(theCorpus, 
                                         RWeka::Weka_control(min = ngramCount, max = ngramCount, 
                                                             delimiters = " \\r\\n\\t.,;:\"()?!"))
  ngramFunction <- data.frame(table(ngramFunction))
  ngramFunction <- ngramFunction[order(ngramFunction$Freq, 
                                       decreasing = TRUE),][1:100,]
  colnames(ngramFunction) <- c("String","Count")
  ngramFunction
}

dir <- "C:/Users/yogesh.godbole/Documents/Yogesh/Data Science/Course5/Capstone/PredictNextWord"
setwd(dir)
unigram <- ngramTokenizer(finalCorpusDF, 1)
saveRDS(unigram, file = "unigram.txt")
bigram <- ngramTokenizer(finalCorpusDF, 2)
bigram <- bigram%>%separate(String,c('w1','w2')," ")
saveRDS(bigram, file = "bigram.txt")
trigram <- ngramTokenizer(finalCorpusDF, 3)
trigram <- trigram%>%separate(String,c('w1','w2','w3')," ")
saveRDS(trigram, file = "trigram.txt")
quadgram <- ngramTokenizer(finalCorpusDF, 4)
quadgram <- quadgram%>%separate(String,c('w1','w2','w3','w4')," ")
saveRDS(quadgram, file = "quadgram.txt")
