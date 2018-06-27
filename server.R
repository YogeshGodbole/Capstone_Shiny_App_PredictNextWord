suppressPackageStartupMessages(c(
  library(shinythemes),
  library(shiny),
  library(tm),
  library(stringr),
  library(markdown),
  library(stylo)))

source("./predictword.R")



shinyServer(function(input, output) {
  
  wordPrediction <- reactive({
    textuser <- input$text
    textInput <- cleanText(textuser)
    wordCount <- length(textInput)
    wordPrediction <- nextWordPrediction(wordCount,textInput)
  
    })
  
  output$predictedWord <- renderPrint(wordPrediction())
  output$enteredWords <- renderText({ input$text }, quoted = FALSE)
})