UserBoxModuleUi <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    uiOutput(ns("userboxid"))
  )
  
  
  
}


UserBoxModuleServer <- function(id, valOne, text, icons = icon("users")){
  
  moduleServer(id, function(input, output, session){
    
    
    output$userboxid <- renderUI({
      

      styled_icon <- tags$i(
        class = icons$attribs$class,
        style = "color: #e0e0e0; font-size: 24px;"
      )
      
      descriptionBlock(
          numberColor = "gray",
          numberIcon = styled_icon,
          header = tags$span(style="color:white; font-size:24px; font-family:sans-serif;",
                             format(valOne, format="d", big.mark=',')),
          text = tags$span(style="color:white; font-size:14px; font-family:sans-serif;",text),
          rightBorder = FALSE,
          marginBottom = FALSE
      )
      
      # descriptionBlock(
      #   
      #   numberColor = "white",
      #   numberIcon = icons,
      #   header = valOne,
      #   text = text,
      #   rightBorder = FALSE,
      #   marginBottom = FALSE
      # )
      
      
    })
    
    
    
  })
  
  
  
}