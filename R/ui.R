ui <- dashboardPage(
  title = "Air Quality",
  skin = "dark",
  fullscreen = TRUE,
  scrollToTop = TRUE, 
 # freshTheme = theme,
  
  # Header -------
  
  header = dashboardHeader(
    #status = "info",
    skin = "light",
    
    title = dashboardBrand(
      title = "Analytics PM2.5",
      image = "https://iili.io/3jSVbGj.jpg"
    )),
    
    sidebar = dashboardSidebar(
      collapsed     = TRUE,
      minified      = TRUE,
      expandOnHover = TRUE,
      sidebarMenu(
        menuItem("Home",tabName = "glance_page", icon = icon("home")),
        menuItem("Dashboard",tabName = "dashboard", icon = icon("bar-chart"))
        
        
      )
      
    ),
  
  
  # Control bar -------
  
  controlbar = dashboardControlbar(),
  
  # Footer --------
  
  footer = dashboardFooter(
    left = "Production Grade Shiny Application",
    right = "2025-26"
  ),
   

  body = dashboardBody(
    

    tabItems(
      tabItem(
        tabName = "glance_page",
        
        fluidRow(
          # First Column: WHO's PM2.5 Concentration
          column(width = 6, offset = 0, 
                 userBox(
                   title = userDescription(
                     title = "WHO's PM2.5 Concentration",
                     subtitle = "Air Quality Life Index",
                     type = 2,
                     image = "https://iili.io/3NCWhFV.png"
                   ),
                   status = "maroon",
                   gradient = TRUE,
                   background = "white",
                   boxToolSize = "xl",
                  # footer = "The footer here!",
                   width = 12,
                   fluidRow(
                     # First Row inside first column
                     column(width = 6, offset = 0,
                            boxPad(
                              color = "info",
                              UserBoxModuleUi("whobox1"),
                              tags$hr(style = "border-top: 1px solid white; margin-top: 10px; margin-bottom: 10px;"),
                              
                              UserBoxModuleUi("whobox5")
                            )
                     ),
                     # Second Row inside first column
                     column(width = 6, offset = 0,
                            boxPad(
                              color = "info",
                              UserBoxModuleUi("whobox2"),
                              tags$hr(style = "border-top: 1px solid white; margin-top: 10px; margin-bottom: 10px;"),
                              UserBoxModuleUi("whobox6")
                            )
                     )
                   )
                 )
          ),
          
          # Second Column: National's PM2.5 Concentration
          column(width = 6, offset = 0, 
                 userBox(
                   title = userDescription(
                     title = "National's PM2.5 Concentration",
                     subtitle = "Air Quality Life Index",
                     type = 2,
                     image = "https://iili.io/3NaYbgs.png"
                   ),
                   status = "maroon",
                   gradient = TRUE,
                   background = "white",
                   boxToolSize = "xl",
                  # footer = "The footer here!",
                   width = 12,
                   fluidRow(
                     # First Row inside second column
                     column(width = 6, offset = 0,
                            boxPad(
                              color = "info",
                              UserBoxModuleUi("whobox3"),
                              tags$hr(style = "border-top: 1px solid white; margin-top: 10px; margin-bottom: 10px;"),
                              UserBoxModuleUi("whobox8")
                            )
                     ),
                     # Second Row inside second column
                     column(width = 6, offset = 0,
                            boxPad(
                              color = "info",
                              UserBoxModuleUi("whobox4"),
                              tags$hr(style = "border-top: 1px solid white; margin-top: 10px; margin-bottom: 10px;"),
                              UserBoxModuleUi("whobox7")
                            )
                     )
                   )
                 )
          )
        )
        
        
      ),
      tabItem(
        tabName = "dashboard",
        
        filterUI_Module(id = "filter_id",data = final_data_with_life_exp)
        
        
      )
      

    
  
)
)
)
