server = function(input, output, session){
 
  # Box 1 
  state_above_who <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count>5) %>% arrange(desc(Count)) %>% count() %>% pull()
  UserBoxModuleServer("whobox1",valOne = state_above_who, text ="Above WHO", icons = icon("house-user"))
  
  # Box 2
  state_below_who <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count<=5) %>% arrange(desc(Count)) %>% count() %>% pull()
  
  UserBoxModuleServer("whobox2",valOne = state_below_who, text ="Below WHO", icons = icon("house-user"))
  
  

  # Box 3 fas fa-map-marker-alt
  state_above_nt <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count>40) %>% arrange(desc(Count)) %>% count() %>% pull()
  UserBoxModuleServer("whobox3",valOne = state_above_nt, text ="Above National", icons = icon("house-user"))
  
  # Box 4
  state_below_nt <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count<=40) %>% arrange(desc(Count)) %>% count() %>% pull()
  
  UserBoxModuleServer("whobox4",valOne = state_below_nt, text ="Below National",icons = icon("house-user"))
  
  
  # Box 5 
  state_above_who_pop <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count>5) %>% 
    distinct(State_Name, Tot_population) %>% summarise(pop_count = sum(Tot_population,na.rm = T)) %>% pull()

 
  
  UserBoxModuleServer("whobox5",valOne = state_above_who_pop, text ="Above WHO", icons = icon("users"))
  
  # Box 6
  state_below_who_pop <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count<=5) %>% 
    distinct(State_Name, Tot_population) %>% summarise(pop_count = sum(Tot_population,na.rm = T)) %>% pull()
  
  
  
  UserBoxModuleServer("whobox6",valOne = state_below_who_pop, text ="Below WHO", icons = icon("users"))
  
  
  # Box 7
  state_below_nt_pop <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count<=40) %>% 
    distinct(State_Name, Tot_population) %>% summarise(pop_count = sum(Tot_population,na.rm = T)) %>% pull()
  
  
  
  UserBoxModuleServer("whobox7",valOne = state_below_nt_pop, text ="Below National", icons = icon("users"))
  
  # Box 8
  state_above_nt_pop <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count>40) %>% 
    distinct(State_Name, Tot_population) %>% summarise(pop_count = sum(Tot_population,na.rm = T)) %>% pull()
  
  
  
  UserBoxModuleServer("whobox8",valOne = state_above_nt_pop, text ="Above National", icons = icon("users"))
  
  # Line Chart
  
  
  
  
  
  
  # Second Page:
  

  filterServer_module(id = "filter_id",data = final_data_with_life_exp)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # filterServer_module("filter_id",data = as.data.table(final_data_with_life_exp))
  # 
  # 
  # data1 <- reactive({
  #   yr_wise_trend_pm2.5 <- filtered_data() %>% filter(Parameter=="PM2.5") %>% select(State_Name, Count, Year) 
  #   
  #   return(yr_wise_trend_pm2.5)
  # })
  # 
  # 
  # mod_line_server(id = "first_line",df = data1, x_col = 'Year',y_cols = 'Count', chart_title = "check",type = "line")
  # 
  # 
  
  # mod_filter_server(id = "mod_filter_id", data = data_used)
  # 
  # print("==============================")
  # 
  # observe(
  #   cat("check",input$state))
  # 
  # 
  # output$lifeLossText <- renderUI({
  #   baseline <- filtered_data()
  #   baseline <- unique(baseline$`Life Expectancy`)
  #   
  #   loss <- calc_life_loss(input$pm25)
  #   remaining <- round(baseline - loss, 2)
  #   
  #   HTML(paste0(
  #     "<b>Estimated Life Lost:</b> ", round(loss, 2), " years<br>",
  #     "<b>Adjusted Life Expectancy:</b> ", remaining, " years"
  #   ))
  # })
  # 
  # output$lifeLossPlot <- renderHighchart({
  #   baseline <- filtered_data()
  #   baseline <- unique(baseline$`Life Expectancy`)
  #   
  #   loss <- calc_life_loss(input$pm25)
  #   adjusted <- baseline - loss
  #   
  #   highchart() %>%
  #     hc_chart(type = "column") %>%
  #     hc_title(text = paste("Life Expectancy for", input$state, "in", input$year)) %>%
  #     hc_xAxis(categories = c("Baseline", "With PM2.5")) %>%
  #     hc_yAxis(title = list(text = "Years")) %>%
  #     hc_add_series(name = "Life Expectancy", data = c(baseline, adjusted), colorByPoint = TRUE)
  # })
  # 
  # output$cigaretteText <- renderUI({
  #   pm <- input$pm25
  #   cig_eq <- round(pm / 22, 1)
  #   
  #   HTML(paste0(
  #     "<b>At ", pm, " µg/m³</b>, your air exposure is roughly equivalent to <b>",
  #     cig_eq, " cigarette(s) per day</b>."
  #   ))
  # })
  # 
  # 
  # output$gaugeChart <- renderHighchart({
  #   highchart() %>%
  #     hc_chart(type = "solidgauge") %>%
  #     hc_title(text = "PM2.5 vs WHO Safe Limit (5 µg/m³)") %>%
  #     hc_pane(
  #       center = list("50%", "85%"),
  #       size = "140%",
  #       startAngle = -90,
  #       endAngle = 90,
  #       background = list(
  #         outerRadius = "100%",
  #         innerRadius = "60%",
  #         shape = "arc"
  #       )
  #     ) %>%
  #     hc_yAxis(
  #       min = 0,
  #       max = 300,
  #       stops = list(
  #         list(0.33, "#55BF3B"),
  #         list(0.66, "#DDDF0D"),
  #         list(1, "#DF5353")
  #       ),
  #       lineWidth = 0,
  #       tickInterval = 50,
  #       labels = list(y = 16),
  #       title = list(text = "PM2.5 (µg/m³)")
  #     ) %>%
  #     hc_add_series(
  #       name = "PM2.5",
  #       data = list(input$pm25),
  #       tooltip = list(valueSuffix = " µg/m³")
  #     ) %>%
  #     hc_tooltip(enabled = TRUE)
  # })
  # 
  # output$scenarioPlot <- renderHighchart({
  #   baseline <- filtered_data()
  #   baseline <- unique(baseline$`Life Expectancy`)
  #   print("888888888888888888888")
  #   print(baseline)
  #   calc_loss <- function(pm) (pm / 10) * 0.98
  #   scenarios <- tibble(
  #     Scenario = c("Current", "National Std (40)", "WHO Limit (5)"),
  #     PM25 = c(input$pm25, 40, 5),
  #     LifeLost = calc_loss(c(input$pm25, 40, 5)),
  #     AdjustedLife = pmax(0, baseline - calc_loss(c(input$pm25, 40, 5)))
  #   )
  #   
  #   highchart() %>%
  #     hc_chart(type = "column") %>%
  #     hc_xAxis(categories = scenarios$Scenario) %>%
  #     hc_yAxis(title = list(text = "Life Expectancy (Years)")) %>%
  #     hc_add_series(
  #       name = "Adjusted Life Expectancy",
  #       data = scenarios$AdjustedLife,
  #       colorByPoint = TRUE,
  #       showInLegend = FALSE,label =TRUE
  #     ) %>%
  #     hc_title(text = paste("What If: Life Expectancy under PM2.5 Scenarios in", input$year)) %>%
  #     hc_tooltip(
  #       pointFormat = "Life Expectancy: <b>{point.y:.2f} years</b><br>PM2.5 Scenario: <b>{point.category}</b>"
  #     )
  # })
  
  
  # # Text
  # 
  # observe(print( input$pm25[1]))
  # 

  
 
  
  # data_life <- reactive({
  #   
  #     baseline <- filtered_data() %>%
  # 
  #       group_by(State_Name) %>%
  #       summarise(
  #         `Life Expectancy` = mean(`Life Expectancy`, na.rm = TRUE),
  #         `Life Loss (WHO)` = round(mean(ifelse(Parameter %in% "LLPP WHO", Count, NA), na.rm = TRUE),0),
  #         `Life Loss (NAT)` = round(mean(ifelse(Parameter %in% "LLPP NAT", Count, NA), na.rm = TRUE),0),
  #         `Adjusted Life Expectancy`  = round(`Life Expectancy` -  `Life Loss (WHO)`, 2)
  #       )
  #   return(baseline)
  #   
  # })
  # 
  # mod_line_server(id = "lifeLossPlot",df = data_life,x_col = "State_Name",y_cols = c("Life Expectancy", "Life Loss (WHO)", "Adjusted Life Expectancy"),chart_title = paste0("Life Expextancy Loss ", input$state),type = "column" )
  
  #mod_line_server(id = "seasonal_ft",df = data_life, x_col = 'season', y_cols = c('playoffs', 'regular'),chart_title = "Season Wise FT Made",type = "line")
  
  
   
  # output$lifeLossPlot <- renderHighchart({
  #   baseline <- filtered_data() %>%
  #     
  #     group_by(State_Name) %>%
  #     summarise(
  #       life_exp = mean(`Life Expectancy`, na.rm = TRUE),
  #       who_llp = mean(ifelse(Parameter %in% "LLPP WHO", Count, NA), na.rm = TRUE),
  #       nat_llp = mean(ifelse(Parameter %in% "LLPP NAT", Count, NA), na.rm = TRUE),
  #       remaining  = round(life_exp - who_llp, 2)
  #     )
  #   
  #   
  #   highchart() %>%
  #     hc_chart(type = "column") %>%
  #     hc_title(text = paste("Life Expectancy for", input$state)) %>%
  #     hc_xAxis(categories = c("Baseline", "With PM2.5")) %>%
  #     hc_yAxis(title = list(text = "Years")) %>%
  #     hc_add_series(name = "Life Expectancy", data = baseline$life_exp , colorByPoint = TRUE) %>% 
  #     hc_add_series(name = "Life Loss (WHO)", data = baseline$who_llp ,  colorByPoint = TRUE) %>% 
  #     hc_add_series(name = "Life Adjusted", data = baseline$remaining ,colorByPoint = TRUE)
  #   
  # })
  
  
  
  
  
}