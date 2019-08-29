#Load Libraries
library(shiny)
library(datasets)
library(dplyr)
#library(shinythemes)

# Define UI 
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Star Wars Character Regressions"),
        
        # Sidebar with checkboxes
        sidebarLayout(
                sidebarPanel(
                        
                        checkboxInput("female", "Include female", value = TRUE)
                        ,
                        checkboxInput("male", "Include male", value = TRUE)
                        ,
                        checkboxInput("outlier", "Include Jabba the Hut", value = F),
                        helpText('Choose subsets of the R Star Wars Characters and calculate linear regressions for variables height and mass. Use the checkboxes above!')
                        ,
                        sliderInput("height", "Your height in cm", value = 170, min = 40, max = 274, 1)
                        
                ),
                
                # Show a plot
                mainPanel(
                        plotOutput("distPlot", width = "100%")
                )
        )
))
