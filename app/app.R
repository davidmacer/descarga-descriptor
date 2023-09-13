library(shiny)
ui <- fluidPage(
  sidebarPanel(
    downloadButton(
      outputId = "descargarDescriptor",
      label = "Crea descriptor de datos"
    )
  )
)
server <- function(input, output, session) {
  # Evento para crear el descriptor de datos
  # observeEvent(input$creaDescriptor, {
  #   session$sendCustomMessage(type = 'testmessage',
  #                             message = 'Thank you for clicking')
  # })
  ### Inicia proceso de descarga de descriptor de datos
  output$descargarDescriptor <- downloadHandler(
    # Nombre del archivo que se va a guardar
    filename = "descriptor.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "tempReport.Rmd")
      file.copy("descriptor_datos.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      # params <- list(n = input$slider)
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        # params = params,
                        envir = new.env(parent = globalenv())
      )
    }
  )
  ### Fin proceso de descarga de descriptor de datos
}
shinyApp(ui, server)
