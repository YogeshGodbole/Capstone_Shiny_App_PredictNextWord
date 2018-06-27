suppressPackageStartupMessages(c(
  library(shiny),
  library(tm),
  library(stylo),
  library(stringr)))

# Loading N-gram for bi, tri and four-gram table
quadData <- readRDS(file="quadgram.txt")
triData <- readRDS(file="trigram.txt")
biData <- readRDS(file="bigram.txt")

# Cleaning model for input text text pre-processing before calling predict module
dataCleaner<-function(text){
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  return(cleanText)
}

# cleaning module for input text as English text
cleanText <- function(text){
  textInput <- dataCleaner(text)
  textInput <- txt.to.words.ext(textInput, 
                                language="English.all", 
                                preserve.case = TRUE)
  
  return(textInput)
}

# Prediction next word module pre-formating before processing
nextWordPrediction <- function(wordCount,textInput){
  # if sentences more or equal to 3 words, take the last 3 words for prediction
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
  }
  else if(wordCount==2) {
    textInput <- c(NA,textInput)  
  }
  else {
    textInput <- c(NA,NA,textInput)
  }
  
  
  # Word prediction main module call 
  # If no word prediction found in Quad-gram table, then back-off call to tri-gram, follows by bi-gram
  
  wordPrediction <- as.character(quadData[quadData$w1==textInput[1] & 
                                            quadData$w2==textInput[2] & 
                                            quadData$w3==textInput[3],][1,]$w4)
  wordPrediction2 <- as.character(quadData[quadData$w1==textInput[1] & 
                                            quadData$w2==textInput[2] & 
                                            quadData$w3==textInput[3],][2,]$w4)
  wordPrediction3 <- as.character(quadData[quadData$w1==textInput[1] & 
                                             quadData$w2==textInput[2] & 
                                             quadData$w3==textInput[3],][3,]$w4)
  
  if(is.na(wordPrediction)) {
    wordPrediction <- as.character(triData[triData$w1==textInput[2] & 
                                              triData$w2==textInput[3],][1,]$w3)
    wordPrediction2 <- as.character(triData[triData$w1==textInput[2] & 
                                             triData$w2==textInput[3],][2,]$w3)
    wordPrediction3 <- as.character(triData[triData$w1==textInput[2] & 
                                             triData$w2==textInput[3],][3,]$w3)
    
    if(is.na(wordPrediction)) {
      wordPrediction <- as.character(biData[biData$w1==textInput[3],][1,]$w2)
      wordPrediction2 <- as.character(biData[biData$w1==textInput[3],][2,]$w2)
      wordPrediction3 <- as.character(biData[biData$w1==textInput[3],][3,]$w2)
    }
  }
  wordPrediction <- paste(wordPrediction,wordPrediction2,wordPrediction3,sep = "  ")
  wordPrediction <-gsub("NA","",wordPrediction)
  print(wordPrediction)
  
}