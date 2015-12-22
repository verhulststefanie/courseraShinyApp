library(shiny)
library(datasets)

shinyServer(function(input, output) {
     
     count <- reactiveValues(i = -1)
     
     output$instruction <- renderText({
          if (count$i %% 3 != 2) "Press the button below for a different image."
          else "This was the last new image. Next button press will bring back the first image."
               
     })

     
     # Based on source: 
     # http://stackoverflow.com/questions/9543343/plot-a-jpg-image-using-base-graphics-in-r
     plot_jpeg = function(path, textTop=NA, textBottom=NA, col="black", add=FALSE){
          require('jpeg')
          tryCatch({
               jpg = readJPEG(path, native=T) ; res = dim(jpg)[1:2]
               op <- par(mar = rep(0, 4))
               if (!add) {
                    plot(1,1,xlim=c(1,res[2]),ylim=c(1,res[1]),asp=1,type='n',xaxs='i',yaxs='i',
                         xaxt='n',yaxt='n',xlab='',ylab='',bty='n')
               }
               rasterImage(jpg,1,1,res[2],res[1])
               text(res[2]/2,14*res[1]/15,textTop,cex=2,col=col)
               text(res[2]/2,res[1]/15,textBottom,cex=2,col=col)
               par(op)
          }, error=function(e) {
               plot(1,1,xlim=c(1,50),ylim=c(1,20),asp=1,type='n',xaxs='i',
                    yaxs='i',xaxt='n',yaxt='n',xlab='',ylab='',bty='n')
               text(25,19,"Wrong input type: please upload a .jpg\nfile or choose cats or dogs.",cex=1.5)
          })
     }

     output$image <- renderPlot({
          textTop = input$textTop
          textBottom = input$textBottom
          colour = input$colour
          inFile <- input$file
          if (is.null(input$catOrDog))
               return(NULL)
          srcCat = "images/cat.jpg"
          srcDog = "images/dog.jpg"
          if(count$i %% 3 == 1) {
               srcCat = "images/cat2.jpg"
               srcDog = "images/dog2.jpg"
          } else if(count$i %%3 == 2){
               srcCat = "images/cat3.jpg"
               srcDog = "images/dog3.jpg"
          } 
          if (input$catOrDog == "Cat") {
               plot_jpeg(srcCat, textTop, textBottom, colour)
          } else if (input$catOrDog == "Dog") {
               plot_jpeg(srcDog, textTop, textBottom, colour)
          }
          if (input$catOrDog == "Own image" & !is.null(inFile))
               plot_jpeg(inFile$datapath, textTop, textBottom, colour)
     }, width = 500)
     
     output$source <- renderText({
          srcCat = "http://i.imgur.com/cUk6dIU.jpg"
          srcDog = "http://fanaru.com/doge/image/18360-doge-doge-simple.jpg"
          if(count$i %% 3 == 1) {
               srcCat = "http://ladydinahs.com/wp-content/uploads/2013/08/maru.jpg"
               srcDog = "http://weknowyourdreams.com/images/dog/dog-03.jpg"
          } else if(count$i %%3 == 2){
               srcCat = "http://cdn2.thr.com/sites/default/files/imagecache/675x380/2014/09/too_good_for_grumpy_cat.jpg"
               srcDog = "http://cdn.images.express.co.uk/img/dynamic/128/590x/husky-583621.jpg"
          } 
          if (input$catOrDog == "Cat") {
               paste("Image source: ",srcCat,sep="")
          } else if (input$catOrDog == "Dog") {
               paste("Image source: ",srcDog,sep="")
          }

     })

     #Source: https://groups.google.com/forum/#!topic/shiny-discuss/IWBghVCcMnI
     observe({ 
          input$another
          isolate({
               count$i <- count$i + 1
          })
     })
})
