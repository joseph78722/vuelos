# Tutorial de automatización de scripts
# https://anderfernandez.com/automatizar-scripts-de-r-en-windows-y-mac/

setwd("~/Vuelos2/docs")

library(httr)
library(jsonlite)
library(leaflet)
library(tidyverse)
library(xml2)
library(rvest)
library(htmlwidgets)


url = "https://opensky-network.org/api/states/all"
datos <- GET(url)

datos <- fromJSON(content(datos, type = "text"))
datos <- datos[["states"]]
datos

# Extraer datos de columnas para saber qué es cada cosa
url = "https://opensky-network.org/apidoc/rest.html"
nombres <- read_html(url) %>% html_nodes("#all-state-vectors")  %>% html_nodes("#response")  %>% html_nodes('.docutils') %>% html_table()
colnames(datos) <- nombres[[2]]$Property
datos <- as.data.frame(datos, stringsAsFactors = FALSE)


# Convertirmos la latitud y longitud en número, ya que vienen en string (texto)
datos$longitude <- as.numeric(datos$longitude)
datos$latitude <- as.numeric(datos$latitude)

# Creamos el mapa
mapa <- leaflet() %>%
  addTiles() %>%
  addCircles(lng = datos$longitude, lat = datos$latitude, color = "#1e3799", opacity = 0.3) %>% 
  addLegend("topright", colors = "#O3F", labels = "Monitoreo de vuelos") %>% 
  addLegend("bottomright", colors = "#O3F", labels = "API:opensky-network.org -- Elaborado por: J. Romero")


saveWidget(mapa, "index.html", selfcontained = F, libdir = "lib")

library(git2r)

repo <-  repository()
add(repo, "*")

commit(repo, message = "actualización 15 minutos")
cred <- cred_token()
push(repo, credentials = cred)
