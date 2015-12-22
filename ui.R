# runApp(paste(getwd(),"/shinyCatDogs",sep=""))
library(shiny)
  
shinyUI(pageWithSidebar(
     headerPanel("Cats and Dogs Meme Generator"),
     sidebarPanel(
          radioButtons("catOrDog", "Choose your animal:",
                       c("Cat", "Dog", "Own image")),
          textOutput("instruction"),
          actionButton("another", "Another!"),
          fileInput("file", label = "Or upload your own image and select the 'Own image' radio button above:",
                    accept = c('.jpg')),
          textInput("textTop",label="Enter the text for the top of the image:",value="Top text..."),
          textInput("textBottom",label="Enter the text for the bottom of the image:",value="Bottom text..."),
          selectInput("colour", "Select text colour:",
                      c("Black"= "black",
                        "White" = "White",
                        "Red" = "red",
                        "Orange" = "orange",
                        "Yellow" = "yellow",
                        "Green" = "green",
                        "Blue" = "lightblue",
                        "Dark blue" = "darkblue",
                        "Violet" = "violet"))
     ),
     mainPanel(
          tabsetPanel(
               tabPanel("Meme Generator", 
                        imageOutput("image", height = "500px"),
                        textOutput("source")),
               tabPanel("Documentation", includeMarkdown("doc.md"))
          )
     )
))