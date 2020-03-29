library(rvest)
library(tidyverse)
library(httr)

url <- GET(url = "https://www.dhs.wisconsin.gov/outbreaks/index.htm")

page <- content(url,as = 'text')

str_extract(page,"table")



tbls <- xml_attr(xml_find_all(page,".//table"), "id")

webpage <- read_html(url)

#Using CSS selectors to scrape the rankings section
tested <- html_nodes(webpage,'table')

#Converting the ranking data to text
data <- html_text(tested)

#Let's have a look at the rankings
head(rank_data)


library(XML)
library(RCurl)
library(rlist)

theurl <- getURL(url,.opts = list(ssl.verifypeer = FALSE) )
tables <- readHTMLTable(theurl)
tables <- list.clean(tables, fun = is.null, recursive = FALSE)
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

