# Load Libraries

library(shiny)
library(tidyverse)
library(tidytext)
library(glue)
library(plotly)


# Read Data 

iris <- read_rds("iris.rds")

iris

ui <- fluidPage(
  titlePanel("Flower dimensions by species"),
  sidebarLayout(
    sidebarPanel(
      p("Use the dropdown menu to narrow the focus of the table"),
      selectInput(
        inputId = "species",
        label = "Select species",
        choices = c("setosa", "versicolor", "virginica"),
        multiple = TRUE
      )
      ),
    mainPanel(
      p("Using the selection box, you can sort through the iris specimens based on Species. You can also use the search function to search for a specific value! The dataset can be accessed on ",
      a("Kaggle", href = "https://www.kaggle.com/gpreda/iris-dataset")),
      dataTableOutput(outputId = ("Specimen_details")
    )
  )))

server <- function(input, output) {
  output$Specimen_details <- renderDataTable({dplyr::filter(
    iris, species %in% input$species)
  })

}

shinyApp(ui = ui, server = server)

