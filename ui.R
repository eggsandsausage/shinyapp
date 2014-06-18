shinyUI(pageWithSidebar(
  headerPanel("Indexinator 2000"),
  sidebarPanel(
    h3('Compose your index'),
    selectInput('variables', 'Select (multiple) variables', multiple=T, 
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
                            "Fertility rate" = "fertilityrate"),
                selected = c("suiciderates","murder","debts","femalefamworkers")),
    sliderInput('yr', 'Choose year',value = 1990, min = 1980, max = 2012, step = 1,animate=T, format="####")
  ),
  mainPanel(  
    
    tabsetPanel(
      tabPanel("Graph", 
               h3("World Performance according to your index"),
               htmlOutput("geochart"), 
               p('Variables with available data for the selected year:'),
               verbatimTextOutput("activevars")
               ),
      tabPanel("Graph/tool explained", 
               h3("What is all this then?"),
               p("This tool allows you to pick and choose from a list of measurements made available by the Gapminder Foundation (gapminder.org). The functionality is quite straight forward: pick and choose variables from the list to compose your index of choice. Use the year slider to see how this index changes over time in the world. All the numbers are relative to the country (ie Internet users per x capita, exports as % of production) to mitigate the effect of different sizes of the countries. Further, the measures are standardized to provide a comparable unit scale (subtract average, divide by standard deviation). In other words, what is actually displayed in the map is how many standard deviations that a particular country deviates given your particulary index."))
    )
  )
))
    