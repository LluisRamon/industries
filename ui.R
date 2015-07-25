library("markdown")
library("shiny")

shinyUI(navbarPage("Industries Agroalimentaries",
                   tabPanel("Inici",
                            fluidRow(
                              column(6, includeMarkdown("inici.md")),
                              column(3,
                                     img(class="img-polaroid",
                                         src="https://c1.staticflickr.com/5/4129/5069523802_7547c97579_b.jpg",
                                         width="486.4",  height="325.85"), 
                                     tags$small(
                                       a(href="https://www.flickr.com/photos/vilanovailageltru/5069523802",
                                         "Source: El mercat de El Parc a taula"), 
                                       a(href="https://www.flickr.com/photos/vilanovailageltru/",
                                         "Ajuntament de Vilanova i la Geltrú")
                                     )
                                     
                                     
                              )
                   )), 
                   
                   tabPanel("Estadistiques",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("sectorsEst", "Selecciona un o diferents sectors", choices = sectorNames , multiple = TRUE), 
                                selectInput("comarquesEst", "Selecciona una o diferents comarques", choices = comarquesNames , multiple = TRUE)
                                
                              ),
                              
                              mainPanel(
                                plotOutput("barplotComarca")
                              )
                            )
                            
                   ),
                   tabPanel("Mapa", 
                            
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("sectors", "Selecciona un o diferents sectors", choices = sectorNames , multiple = TRUE), 
                                selectInput("comarques", "Selecciona una o diferents comarques", choices = comarquesNames , multiple = TRUE)
                              ),
                   
                              mainPanel(
                                  plotOutput("mapa")
                              )
                            )
                            ),
                   
                   tabPanel("Base de dades",                
                                dataTableOutput("bbdd")
                    )


))

