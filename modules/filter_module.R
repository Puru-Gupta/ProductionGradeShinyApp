filterUI_Module <- function(id, data){
  
  ns <- NS(id)
  
  tagList(
    
    fluidRow(
      
      bs4Card(
        title = "User Input",
        width = 12,
        status = "primary",
        solidHeader = FALSE,
        
        pickerInput(
          inputId = ns("state"),
          label = "Select State(s):",
          choices = unique(sort(data$State_Name)),
          selected = unique(sort(data$State_Name)),
          multiple = T,
          options = list(
            `actions-box` = TRUE,
            size = 5,
            `selected-text-format` = "count > 2",
            `live-search`=TRUE
          )),
        
        
        pickerInput(
          inputId = ns("year"),
          label = "Select Year(s):",
          choices = unique(sort(data$Year)),
          selected = unique(sort(data$Year)),
          multiple = T,
          options = list(
            `actions-box` = TRUE,
            size = 5,
            `selected-text-format` = "count > 2",
            `live-search`=TRUE
          ))
      
                           
                           
                           )
        ) 
      )
  
}



filterServer_module <- function(id, data){
  
  moduleServer(id, function(input, output, session){
    
    
    rv_state <- reactiveValues()
    rv_year <- reactiveValues()
    
    isolate({
      rv_state$state <- input$state
      rv_year$year   <- input$year
      
    })
    
    # state_level_pop_weighted_pollution[State_Name %in% "Uttar Pradesh"]
    
    # Dyanmics Year Filtering
    
    observeEvent(rv_state$state, {
      
      updatePickerInput(session, inputId = "year",
                        label    = "Select Year(s):",
                        choices  =  unique(data %>% filter(State_Name %in% rv_state$state) %>% pull(Year)),
                        selected =  unique(data %>% filter(State_Name %in% rv_state$state) %>% pull(Year)))
      
    })
    
    
    observe({
      
      if(!isTRUE(input$state_open) & !isTRUE(input$year_open)){
        
        rv_state$state <- input$state
        rv_year$year   <- input$year
        
      }
      
    })
    
    # Store Filtered Data
    
    
  filtered_data <<-  reactive({
    
    data_df <- data
     
     data_test <- data_df %>% filter(State_Name %in% rv_state$state &
                       Year %in% rv_year$year)
                         
     
     return(as.data.frame(data_test))
     
   })
    
    
    
    
    
  })
  
}


