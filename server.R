
#library(UsingR)
library(googleVis)
library(reshape2)
choices = c("Internet users" = "iusers", 
            "cell phone owners" = "cellphones", 
            "Exports (% of GDP)" = "exports", 
            "External debt" = "debts", 
            "GDP per capita" = "gdp", 
            "High tech exports" = "hightechexports", 
            "Murder rate" = "murder", 
            "CO2 emissions per capita" = "co2emissions", 
            "Life Expectancy" = "lifeexpectancy", 
            "Motor vehicle owners (4 wheels)" = "motorvehicles", 
            "Youth (15-24) literacy rate" = "youthliteracy", 
            "Electricity consumed per capita" = "electrictyconsumed", 
            "BMI average females" = "BMIfemale", 
            "BMI average males" = "BMImale", 
            "Female labourers (15-64) % of pop" = "femaleworkpop", 
            "Female family workers %" = "femalefamworkers", 
            "Male family workers %" = "malefamworkers", 
            "HIV Ages 15-49 % of pop" = "HIV", 
            "Unemployment ages 15-24" = "unemp15-24", 
            "Unemployement ages 25-54" = "unemp25-54", 
            "Suicide rates" = "suiciderates", 
            "Illiteracry rate female youth (15-24)" = "femalyouthliteracy", 
            "Fertility rate" = "fertilityrate")
dataset <- read.csv("dataset2.csv", check.names=F)
dataset <- dataset[complete.cases(dataset),]
dataset$country <- sub("\\n", "", dataset$country)
emptymap <- data.frame("country"=0, "value"=0)
shinyServer(
  function(input, output) {
    output$activevars <- reactive({
      graphset <- reactivedataset()
      rownos <- by(graphset, graphset$type, nrow)
      activevars <- names(rownos[complete.cases(rownos[rownos > 0])])
      
      if (length(activevars)==0){
        return("")
      } else {
        
      return(names(choices[match(activevars, choices)]))
      }
    })
    reactivedataset <- reactive({
                                graphset <- dataset[dataset$type %in% input$variables,]
                                graphset <- graphset[graphset$year==input$yr,]
                                 for (variable in input$variables) {
                                   graphset[graphset$type==variable,"value"] <- (graphset[graphset$type==variable,"value"] - mean(graphset[graphset$type==variable,"value"]))/sd(graphset[graphset$type==variable,"value"]) 
                                 }
                                 
                                if (nrow(graphset) >0){ 
                                  graphset <- aggregate(list(value = graphset$value),by=list(country = graphset$country,year = graphset$year, type=graphset$type), FUN=sum, na.rm=T)
                                }                                   
                                return(graphset)

                                 })
    output$geochart <- renderGvis({
      if(nrow(reactivedataset()) > 0){
        return(gvisGeoChart(data=reactivedataset(), locationvar="country", colorvar="value"))
      } else {
        return(gvisGeoChart(data=emptymap, locationvar="country", colorvar="value"))
      }
      
    })
    output$something <- renderPrint(emptymap)
    
  }
)
