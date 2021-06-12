library(shiny)
library(tidyverse)

data(iris)

ui <- fluidPage(
  titlePanel("Flower dimensions by species"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "species",
        label = "Select species",
        choices = c("setosa", "versicolor", "virginica"),
        multiple = TRUE
      ),
      sliderInput(
        inputId = "specimen_selection",
        label = "Select specimen range",
        min = min(iris$Sepal.Length),
        max = max(iris$Sepal.Length),
        value = 2
      )),
    sliderInput(
      inputId = "specimen_selection",
      label = "Select specimen range",
      min = min(iris$id, na.rm = TRUE),
      max = max(iris$id, na.rm = TRUE),
      value = 2
    ),
    mainPanel(
      dataTableOutput(outputId = "Specimen_details")
    )
  )
)

server <- function(input, output) {
  output$Specimen_details <- renderDataTable({dplyr::filter(
    iris, Species %in% input$species) 
    })
 }

shinyApp(ui = ui, server = server)
