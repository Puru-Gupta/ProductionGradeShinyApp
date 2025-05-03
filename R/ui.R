ui <- dashboardPage(
  title = "Air Quality",
  dark = NULL,
  help = NULL,
  fullscreen = TRUE,
  scrollToTop = TRUE,
  
  # Header -------
  
  header = dashboardHeader(
    status = "olive",
    title = dashboardBrand(
      title = "Analytics PM2.5",
      color = "olive",
      image = "https://iili.io/3jSVbGj.jpg"
      
    )),
    
    sidebar = dashboardSidebar(
      sidebarMenu(
        menuItem("Home",tabName = "glance_page", icon = icon("home")),
        menuItem("Analytics",tabName = "main_page", icon = icon("bar-chart"))
        
        
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
    
    

  )

  
)