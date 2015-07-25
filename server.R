library("ggmap")
library("RgoogleMaps") # MaxZoom es de RgoogleMaps
library("shiny")


shinyServer(function(input, output) {
  
  # Estadistiques
  output$barplotComarca <- renderPlot({
    
    cond <- TRUE
    
    if(!is.null(input$sectorsEst)){
      cond <- industries$sectorSim %in% input$sectorsEst
    }
    
    if(!is.null(input$comarquesEst)){
      cond <- cond & industries$Comarca %in% input$comarquesEst
    }
    
    
    indCond <- industries[cond, c("Comarca", "sectorSim")]
    
    gComarca <- qplot(Comarca, fill = Comarca, data =  indCond, xlab = "", ylab = "") + 
      theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position = "bottom", 
            legend.title=element_blank(), legend.text=element_text(size=8)) + 
      guides(fill=FALSE)
    print(gComarca)
  })
  
  # Mapes
  output$mapa <- renderPlot({
    
    cond <- TRUE
    
    if(!is.null(input$sectors)){
      cond <- industries$sectorSim %in% input$sectors
    }
    
    if(!is.null(input$comarques)){
      cond <- cond & industries$Comarca %in% input$comarques
    }
    
    indCond <- industries[cond, c("lon", "lat", "sectorSim")]
    
    center <- c(mean(indCond$lon, na.rm = TRUE), 
                mean(indCond$lat, na.rm = TRUE))
    zoom <- min(MaxZoom(range(indCond$lat, na.rm = TRUE), 
                        range(indCond$lon, na.rm = TRUE)))
    mapa <- get_map(location = center, zoom = zoom, maptype =  "roadmap", color = "bw")
    gmapa <- ggmap(mapa, extent = "device") + 
      geom_point(data = indCond, aes(lon, lat, color = sectorSim)) +
      theme(legend.title=element_blank())
    
    print(gmapa)
  })
  
  # Base de dades
  output$bbdd <- renderDataTable({indust <- industries[, c("Establiment", "Municipi", 
                                                            "Comarca", "sectorSim", "Descripcio", 
                                                            "Telefon")]
                                   names(indust) <- c("Establiment", "Municipi", 
                                                      "Comarca", "Sector", "Descripcio", 
                                                      "Telefon")
                                   indust
  }, 
  options = list(pageLength = 5))

    
  
})
