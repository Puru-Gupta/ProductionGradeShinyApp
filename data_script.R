
# read data

data_df <- read_csv("D:/ProdGradeShiny/data/India_AirQuality_PM2.5.csv")

data_df <- data_df %>% rename(State_Name = name_1, District_Name = name_2)

# Calculate the population weighted pollution of all the year

pollution_year <- grep("^pm", x = colnames(data_df), value = TRUE)

state_level_pop_weighted_pollution <- data_df %>% 
  group_by(State_Name) %>% summarise(
    
    across(all_of(pollution_year), ~sum(.*population, na.rm = T)/sum(population, na.rm = T))
    
  )


## Second way

# state_level_pop_weighted_pollution_2 <- data_df %>% 
#   group_by(State_Name) %>% 
#   summarise(pm1998_avg = sum(pm1998*population)/sum(population),
#             pm1999_avg = sum(pm1999*population)/sum(population)
#             )


yr_wise_trend_pm2.5 <- state_level_pop_weighted_pollution %>% filter(State_Name %in% "Haryana") %>% 
  pivot_longer(!State_Name,names_to = "Year", values_to = "PM2.5")

yr_wise_trend_pm2.5$Year <- gsub("[^0-9]", "", yr_wise_trend_pm2.5$Year)
yr_wise_trend_pm2.5$Year <- as.integer(yr_wise_trend_pm2.5$Year)

highchart() %>%
  hc_title(text = paste0(unique(yr_wise_trend_pm2.5$State_Name),  " Population-Weighted PM2.5 (1998–2021)")) %>%
  hc_xAxis(categories = yr_wise_trend_pm2.5$Year, title = list(text = "Year")) %>%
  hc_yAxis(title = list(text = "PM2.5 (µg/m³)")) %>%
  hc_add_series(name = "PM2.5", data = round(yr_wise_trend_pm2.5$PM2.5, 1), type = "line", color = "#C8102E", dataLabels = list(enabled = FALSE)) %>%
  hc_tooltip(pointFormat = "<b>{point.y} µg/m³</b> in {point.category}") %>%
  hc_exporting(enabled = TRUE)

###############################################################################################

req_col <- c("objectid_gadm2", "iso_alpha3", "country", "State_Name", "District_Name", "population",    
             "whostandard","natstandard" )

pop_wt_pl_col <- data_df %>% select(!all_of(req_col)) %>% colnames()

state_level_pop_weighted_pollution <- data_df %>% 
  group_by(State_Name) %>% summarise(
    
    across(all_of(pop_wt_pl_col), ~sum(.*population, na.rm = T)/sum(population, na.rm = T)),
    Tot_population = sum(population, na.rm = T)
    
  )

state_level_pop_weighted_pollution <- state_level_pop_weighted_pollution %>% 
  pivot_longer(!c('State_Name','Tot_population'),names_to = "Year", values_to = "Count") %>% 
  mutate(
    
    Parameter = case_when(
      
      grepl("pm", x = Year) ~ "PM2.5",
      grepl("llpp_nat", x = Year) ~ "LLPP NAT",
      grepl("llpp_who", x = Year) ~ "LLPP WHO",
      TRUE ~ "Other"
 
      
    )
    
    
  ) 

state_level_pop_weighted_pollution$Year <- gsub("[^0-9]", "", state_level_pop_weighted_pollution$Year)

state_level_pop_weighted_pollution$Year <- as.integer(state_level_pop_weighted_pollution$Year)


# read data of Life Expectancy

life_exp <- read_csv("D:/ProdGradeShiny/data/state_wise_life_expectancy_india.csv")

final_data_with_life_exp <- left_join(state_level_pop_weighted_pollution, life_exp, by = c("State_Name"=  "State/UT"))
final_data_with_life_exp$Count <- round(final_data_with_life_exp$Count)
#final_data_with_life_exp <- final_data_with_life_exp %>% mutate(PM25_flag = ifelse(Parameter=="PM2.5", Count, NA_integer_))


data_used <- final_data_with_life_exp %>% pivot_wider(names_from = Parameter, values_from = Count) %>% select(!c("LLPP WHO", "LLPP NAT" ))
data_used <- data.table(data_used)

###

# state that has pm2.5 level more than WHO standard for latest year

state_above_who <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count>5) %>% arrange(desc(Count)) %>% count() %>% pull()

state_less_who <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count<=5) %>% arrange(desc(Count)) %>% count() %>% pull()

state_above_nat <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count >40) %>% arrange(desc(Count)) %>% count() %>% pull()

state_above_nat <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count <=40) %>% arrange(desc(Count)) %>% count() %>% pull()


# top_5_state_above_who <- state_level_pop_weighted_pollution %>% filter(Year== max(Year) & Parameter=="PM2.5" & Count>5) %>% 
#   select(State_Name, Tot_population) %>% unique() %>% summarise(tot_pop = sum(Tot_population, na.rm = T)) %>% pull()
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# ###
# 
# 
# 
# 
# 
# col_one <- c( "objectid_gadm2", "iso_alpha3", "country", "State_Name", "District_Name", 
#               "population", "whostandard", "natstandard")
# 
# colna_nms <- data_df %>% select(!all_of(col_one)) %>% colnames()
# 
# 
# state_level_pop_weighted_pollution <- data_df %>% 
#   group_by(State_Name) %>% summarise(
#     
#     across(all_of(colna_nms), ~sum(.*population, na.rm = T)/sum(population, na.rm = T))
#     
#   )
# 
# 
# state_wise_data <- state_level_pop_weighted_pollution %>% 
#                         pivot_longer(!State_Name,names_to = "Year", values_to = "Count") %>% 
#   mutate(
#     Parameter = case_when(
#       grepl("pm", Year, ignore.case = TRUE) ~ "PM2.5",
#       grepl("llpp_who", Year, ignore.case = TRUE) ~ "WHO LLPP",
#       grepl("llpp_nat", Year, ignore.case = TRUE) ~ "NT LLPP",
#       TRUE ~ "Other"
#     )
#   )
# 
# state_wise_data$Year <- gsub("[^0-9]","", state_wise_data$Year)
# 
# 
# state_wise_data<- state_wise_data %>% filter(State_Name %in% "NCT of Delhi")
# 
# 
# highchart() %>%
#   hc_title(text = "Delhi's Population-Weighted PM2.5 (1998–2021)") %>%
#   hc_subtitle(text = paste0("State Name: ", unique(state_wise_data$State_Name))) %>%
#   
#   # X-axis
#   hc_xAxis(categories = unique(state_wise_data$Year), title = list(text = "Year")) %>%
#   
#   # Multiple Y-axes
#   hc_yAxis_multiples(
#     list(   # Left Y-axis (index 0)
#       title = list(text = "PM2.5 (µg/m³)"),
#       labels = list(style = list(color = "#C8102E"))
#     ),
#     list(   # Right Y-axis (index 1)
#       title = list(text = "Life Expectancy Lost (years)"),
#       opposite = TRUE,
#       labels = list(style = list(color = "#1D428A"))
#     )
#   ) %>%
#   
#   # PM2.5 series (left axis)
#   hc_add_series(
#     name = "PM2.5",
#     data = round(state_wise_data$Count[state_wise_data$Parameter == "PM2.5"], 1),
#     type = "line",
#     color = "#C8102E",
#     yAxis = 0
#    # dataLabels = list(enabled = TRUE)
#   ) %>%
#   
#   # WHO LLPP series (right axis)
#   hc_add_series(
#     name = "WHO LLPP",
#     data = round(state_wise_data$Count[state_wise_data$Parameter == "WHO LLPP"], 1),
#     type = "line",
#     color = "#1D428A",
#     yAxis = 1
#     #dataLabels = list(enabled = TRUE)
#   ) %>%
#   
#   hc_exporting(enabled = TRUE)
# 
# 
# 
# # Top 5 Most Polluted State
# 
# top_5_state <- state_wise_data %>% filter(Parameter=="PM2.5", Year=="2021") %>% group_by(Year) %>% arrange(Count)#
# #%>% filter()
# 
# State_pm2.5_more_who <- state_wise_data %>% filter(Parameter=="PM2.5" & Year ==max(Year) & Count>5) %>% count() %>% pull()
# 
# State_pm2.5_less_who <- state_wise_data %>% filter(Parameter=="PM2.5" & Year ==max(Year) & Count<=5) %>% count() %>% pull()
# 
# State_pm2.5_more_nt <- state_wise_data %>% filter(Parameter=="PM2.5" & Year ==max(Year) & Count>40) %>% count() %>% pull()
# 
# State_pm2.5_less_nt <- state_wise_data %>% filter(Parameter=="PM2.5" & Year ==max(Year) & Count<=40) %>% count() %>% pull()
# 
# 
# 
# 
# 
# 
# ##############
# 
# state_wise_data_year <- state_wise_data %>% filter(Year =="2021",Parameter=="PM2.5") %>% arrange(Count)
#   
# highchart() %>%
#   hc_title(text = "Delhi's Population-Weighted PM2.5 (1998–2021)") %>%
#   #hc_subtitle(text = paste0("State Name: ", unique(state_wise_data$State_Name))) %>% 
#   hc_xAxis(categories = state_wise_data_year$State_Name, title = list(text = "Year")) %>%
#   hc_yAxis(title = list(text = "PM2.5 (µg/m³)")) %>%
#   hc_add_series(name = "PM2.5", data = round(state_wise_data_year$Count, 1), type = "column", color = "#C8102E", dataLabels = list(enabled = FALSE)) %>%
#   hc_tooltip(pointFormat = "<b>{point.y} µg/m³</b> in {point.category}") %>%
#   hc_exporting(enabled = TRUE)
# 
# 
# state_wise_data_year <- state_wise_data %>% filter(Year =="2021",Parameter=="WHO LLPP") %>% arrange(Count)
# 
# highchart() %>%
#   hc_title(text = "Delhi's Population-Weighted PM2.5 (1998–2021)") %>%
#   #hc_subtitle(text = paste0("State Name: ", unique(state_wise_data$State_Name))) %>% 
#   hc_xAxis(categories = state_wise_data_year$State_Name, title = list(text = "Year")) %>%
#   hc_yAxis(title = list(text = unique(state_wise_data_year$Year))) %>%
#   hc_add_series(name = "PM2.5", data = round(state_wise_data_year$Count, 1), type = "column", color = "#C8102E", dataLabels = list(enabled = FALSE)) %>%
#  # hc_tooltip(pointFormat = "<b>{point.y} µg/m³</b> in {point.category}") %>%
#   hc_exporting(enabled = TRUE)
# 

state_level_pop_weighted_pollution <- as.data.table(state_level_pop_weighted_pollution)

