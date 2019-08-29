#Load Libraries
library(shiny)
library(datasets)
data(starwars)

server <- function(input, output) {
      
      step1  <- reactive({
                      
        sw <- data.frame(starwars)
                      
                      if(input$outlier == FALSE){
                        sw <- sw[-16,]
                      }
                      if(input$male == FALSE){
                        #mm <- sw[sw$gender=='male',]
                        sw <- subset(sw, gender != 'male') 
                      } 
                      if(input$female == FALSE){
                        #ff <- sw[sw$gender=='female',]
                        sw <- subset(sw, gender != 'female') 
                      } 
                      if(input$female == FALSE && input$male == FALSE && input$outlier == FALSE){
                        return(NULL)
                      } 
                      if(input$height){
                        #good
                      }
        return(sw)
      })
      
      step2  <- reactive({
        
          yh <- input$height
        
          return(yh)
        
      })
      
  output$distPlot <- renderPlot({
   sw <- step1()
   if(!is.null(sw)) {
     model1 <- lm(sw$height ~ sw$mass)
     
     #data <= c( step2() )
     pred <- (step2() - summary(model1)$coefficients[1, 1]) / summary(model1)$coefficients[2, 1]
     #pred <- predict(model1, data)
     
     plot( sw$mass,sw$height, xlab = "Mass",
           ylab = "Height", bty = "n", pch = 19)
            abline(model1, col = "red", lwd = 4)
            text(sw$mass, sw$height,  sw$name,
                 cex=0.88, pos=3, col="black") 
            mtext(paste('Slope ', round(summary(model1)$coefficients[2, 1],2)), side=3)
            mtext(paste('Intercept ', round(summary(model1)$coefficients[1, 1],2)), side=1, line = -2)
            
              mtext(paste('Your alter ego star wars character has a mass (weight on earth) of ', round(pred,1), ' kgs'), side=1, line =4.0, col = 'red', cex=1.3)
           
   }
  }, height = 650, width = 950 )
}