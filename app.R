library(shiny)
animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

ui <- fluidPage(
  # Inputs ----
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  numericInput("number",label = "Number",min = 100,max=1150,value = 130),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3),
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100, animate = TRUE),
  selectInput("state", "What's your favourite state?", state.name, multiple = TRUE),
  radioButtons("animal", "What's your favourite animal?", animals),
   radioButtons("rb", "Choose one:",
    choiceNames = list(
      icon("angry"),
      icon("smile"),
      icon("sad-tear")
    ),
    choiceValues = list("angry", "happy", "sad")
  ),
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?"),
  checkboxGroupInput("animal", "What animals do you like?", animals),
  # Defaults to US standards
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on vacation next?"),
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail")), #<- paired with eventReactive / observeEvent
  # Outputs ----
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  # Create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    # Use a reactive expression by calling it like a function
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}

shinyApp(ui, server)