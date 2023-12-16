library(animint2)
data(WorldBank)

unique_years <- unique(WorldBank$year)
WorldBankLast5 <- data.frame()

for (y in unique_years ) {
  last_five <- subset(WorldBank, y-5 <= year & year < y)
  if (nrow(last_five) > 0) {
    last_five$year <- y
    WorldBankLast5  <- rbind(WorldBankLast5, last_five)
  } 
}

scatter <- ggplot()+
  geom_point(aes(
    x=life.expectancy, 
    y=fertility.rate, 
    color=region,
    key=country),
    showSelected="year",
    clickSelects="country",
    data=WorldBank)+
  geom_path(aes(x=life.expectancy,
                y=fertility.rate, 
                color=region,
                key=country, 
                group=country),
            showSelected="year",  
            data=WorldBankLast5)  
viz.scatter <- animint(scatter,   
                       duration=list(year=2000),
                       title="Worldbank data last 5 years", 
                       source="https://github.com/siddhesh195/worldbank_geom_path/main/TestEasy.R")
animint2pages(viz.scatter, 
              github_repo = "worldbank_geom_path",
              commit_message = "Worldbank data last 5 years",
              required_opts = NULL)