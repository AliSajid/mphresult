#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(stringr)
#library(kableExtra)

# Read the data in
if (file.exists("data.txt")) {
  df <- read_tsv("data.txt", na = c("ABSENT", ""))
} else {
  df <- read_tsv("https://gist.githubusercontent.com/AliSajid/4cbe5a684a5b922224d119bdff1cced3/raw/a0a1697f48335272038c490a5d559493dfd1b07d/data.txt", na = c("ABSENT", ""))
}

# Clean up the data
clean.df <- df %>%
  rename(`Serial #` = `Sr. #`,
         `Roll #` = `Roll Number`,
         Name = `Name of Candidate`,
         `Marks Obtained` = `Obtained Marks (out of 100)`) %>%
  mutate(Gender = as.factor(ifelse(str_detect(Name, "S/O"), "Male", "Female")),
         Name = str_replace(Name, "D/0", "D/O"),
         Ranking = rank(-`Marks Obtained`, ties.method = "min"),
         Attendance = as.factor(ifelse(is.na(`Marks Obtained`), "Absent", "Present"))) %>%
  separate(Name, c('Name', "Father's Name"), sep = "(S|D)/O") %>%
  group_by(Gender) %>%
  mutate(`Rank Within Gender` = rank(Ranking, ties.method = "min")) %>%
  ungroup

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$searchTable <- renderTable({
    clean.df %>%
      filter(startsWith(Name, input$name))
  })
  
})
