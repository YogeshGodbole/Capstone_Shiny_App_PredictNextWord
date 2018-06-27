Capstone_Project_Deck
========================================================
author: Yogesh Godbole
date: 27 June 2018
autosize: true

The predict next word application takes as input a string and predicts the next word based on the last three, two or one words.

Cleaning and Sampling Input Data to build the model
========================================================

-The prediction model is built on a corpus of data built from blogs/twitter messages and news feeds.

-The model is created using a sample of 5000 records each from the above sources.

-The input data is cleaned to remove any special characters/ punctuation marks and converted to lower case

-Its all parsed to remove any words indicating profanity.


Creating N Grams
========================================================

-The N gram tokenizer from the R Weka package is used to create bi-grams, tri-grams and quad-grams.

-The top 100 entries (with highest frequency) from each N-gram are loaded to the shiny app.


The Shiny App
========================================================

The application be accessed at :
https://godboleyogesh.shinyapps.io/PredictNextWord/

It takes as input a string and predicts the next word - provides 3 possible options using the quad gram/ tri gram/bi grams.

It works for sentences in English only.
