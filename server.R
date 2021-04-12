#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2) #Data Visualisatie
library(tidyverse) #R Tidyverse
library(lubridate) #Voor datum manipulatie
library(odbc) #Connectie naar SQLServer
library(tmap)
library(sp)
library(sf)
library(shiny)
library(shinydashboard)


setwd("~/Semester 4/Genuine Challenge/Melbourne Housing")
df <- read_csv("dfm.csv")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #dfplot <- df%>%filter(Bedroom2 == input$Bedrooms, between(Price, input$Budget[1], input$Budget[2]), CouncilArea %in% input$Location)
    output$distPlot <- renderPlot({

        # # generate bins based on input$bins from ui.R
        # x    <- faithful[, 2]
        # bins <- seq(min(x), max(x), length.out = input$Bedrooms + 1)
        # 
        # # draw the histogram with the specified number of bins
        # hist(x, breaks = bins, col = 'darkgray', border = 'white')
        dfplot <- df%>%filter(Bedroom2 == input$Bedrooms, between(Price, input$Budget[1], input$Budget[2]), CouncilArea %in% input$Location)
        ggplot() +
            xlim(min(dfplot$Longtitude), max(dfplot$Longtitude))+
            ylim(min(dfplot$Lattitude), max(dfplot$Lattitude))+
            geom_path(data = mlbndf, aes(x = long, y = lat, group = group)) +
            geom_point(data = dfplot, aes(Longtitude, Lattitude, col = diffperc, size = Price), alpha = 0.5)+
            scale_color_gradient(low = "red", high = "green")
            

    })
     output$tabel <- renderDataTable({
         dfplot <- df%>%filter(Bedroom2 == input$Bedrooms, between(Price, input$Budget[1], input$Budget[2]), CouncilArea %in% input$Location)#%>%select(Address, Price, pred_val, YearBuilt, Rooms)
         dfplot <- dplyr::select(dfplot, Address, Price, pred_val, YearBuilt, Rooms)
         dfplot
     })

})
