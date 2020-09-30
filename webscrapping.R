# install packages
#install.packages("rvest")
#install.packages("tidyverse")

# calling packages
library(rvest)
library(tidyverse)
library(dplyr)
library(magrittr)
library(scales)

# reading site

info_fin = read_html("https://www.sbif.cl/sbifweb/servlet/InfoFinanciera?indice=4.1&idCategoria=550&tipocont=0")

# search the wanted link

urls = info_fin %>%
  html_nodes(xpath = '//*[@id="accordion7877"]/p[2]/a[1]') %>%
  html_attr("href")

download.url = str_c("https://www.sbif.cl/sbifweb/servlet/",urls)

info_fin = read_html(download.url)

urls = info_fin %>%
  html_nodes(xpath = '//*[@id="divBotonDescarga"]/a') %>%
  html_attr("href")

download.url = str_sub(urls, start = 7)
urls = str_c("https://www.sbif.cl/",download.url)

# destfile

dest = str_c("C:/Users/cicon/Downloads/", str_sub(urls, start = 48))

download.file(urls, dest, mode = "wb")   

# to extract data from file

unzip(zipfile= dest,exdir="C:/Users/cicon/Downloads")

folds = list.files(path = "C:/Users/cicon/Downloads")
fold = str_c("C:/Users/cicon/Downloads", "/", folds[1])
files = list.files(fold, ".txt")

