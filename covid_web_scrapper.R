library(rvest)

# porting over the webscrapper that was made in PY here: https://github.com/pzhess/covid-19-analysis/blob/master/web_scraper.py



function_csv_to_tibble <- function(master_tibble){
  
  
}

csv_appender <- function(x){
  if(grepl(".csv",x)==TRUE){
    real_url = paste("https://github.com",x,sep = '')
    return(real_url)
  }
}

data_appender <- function(x){
  temp_html <- read_html(x) 
  temp_html <- as.data.frame(html_table(temp_html,header=TRUE))
  colnames(temp_html)[3] <- 'Country'
  colnames(temp_html)[1] <- 'Garbage'
  temp_html <- filter(temp_html, Country == "US")
  print(temp_html)
  all_data<-bind_rows(c(temp_html,all_data))
  print(all_data)
  }

covid_reader <- function(all_flag) {
  html_data <- read_html("https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports")
  links <- html_data %>% html_nodes('a') %>% html_attr("href")
  csvs_list<-lapply(links,csv_appender)
  csvs_list <- csvs_list[-which(sapply(csvs_list, is.null))]
  all_data <- NULL
  #for loops typically aren't appreciated in R, but this works
  for (x in csvs_list){
    final_data<-data_appender(x)
  }
  
  
}

