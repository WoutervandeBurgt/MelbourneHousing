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
    titlePanel("House Prices in Melbourne"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("Bedrooms",
                        "Number of bedrooms:",
                        min = 1,
                        max = max(df$Bedroom2),
                        value = 3),
            # sliderInput("Budget",
            #             "Maximum Budget:",
            #             min = min(df$Price),
            #             max = max(df$Price),
            #             value = mean(df$Price)),
            sliderInput("Budget", "Budget:",
                        min=min(df$Price), max=max(df$Price),  value= c(quantile(df$Price, 0.25),quantile(df$Price, 0.75)), 
                        pre="$", sep=","),
            selectInput("Location", "Location:", df$CouncilArea, multiple = T, selected = c("Yarra")),
            sliderInput("Distance", "Distance to Central Business District:", min=min(df$Distance), max=max(df$Distance), value= c(0, mean(df$Distance)))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
            
        )
    ),
    dataTableOutput("tabel")
))
