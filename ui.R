#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Masters Related To Public Health Results"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("name",
                   "Name of Student",
                   placeholder = "Name of Student"),
       radioButtons("attendence",
                    "Attendance",
                    choices = c("Present", "Absent", "All"),
                    selected = "All"),
       radioButtons("gender",
                    "Gender",
                    choices = c("Male", "Female", "All"),
                    selected = "All"),
       checkboxInput("ordered",
                     "Ordered?")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tableOutput("searchTable")
    )
  )
))
