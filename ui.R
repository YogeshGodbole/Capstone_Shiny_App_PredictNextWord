suppressPackageStartupMessages(c(
  library(shiny),
  library(tm),
  library(stringr)))

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Word Prediction Application","Data Science Capstone Project"),
  sidebarPanel(
    wellPanel(
      textInput('text', "Type Your Words",""),
      h5('Please press \'Submit\' to see the word prediction result.'),
      h5('(Example:\'i am looking\' or \'hope to see\')'),
      actionButton("submit","Submit")
    )
  ),
  
  mainPanel(
    h3('Word Prediction Result'),
    h5('The main objective of application is to predict the next word likely to come next.'),
    h5('Please allow around 15 seconds for the app to load.'),
    h5('Wait a few seconds after submit your words. Input only English words.'),
    h4('You had entered'),
    verbatimTextOutput("enteredWords"),
    h4('Predicted next words (up to 3):'),
    verbatimTextOutput("predictedWord")
    
  )
)
)