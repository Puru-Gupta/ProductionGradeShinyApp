library(dplyr)
library(shiny)
library(bs4Dash)
library(readr)
library(fresh)

library(tidyr)
library(highcharter)
library(shinyWidgets)
library(data.table)
###################################################
# read Data

source("D:/ProdGradeShiny/data_script.R")

# read Module

source("D:/ProdGradeShiny/modules/user_box_module.R")
source("D:/ProdGradeShiny/modules/filter_module.R")
#source("D:/ProdGradeShiny/modules/line_chart_module.R")















calc_life_loss <- function(pm25) {
  # Simplified function: 0.98 years lost per 10 µg/m³ of PM2.5
  return((pm25 / 10) * 0.98)
}




