
library(haven)
library(tidyr)
library(dplyr)
library(serad)
library(openxlsx)
path = paste0(getwd(),'/data/')

#Import des bordereaux pertinents (bases statistiques 2022)
#bases statistiques 2022 : https://data.drees.solidarites-sante.gouv.fr/explore/dataset/708_bases-statistiques-sae/information/
#ressource particulièrement utile: l'Aide au remplissage

#Note: bases administratives 2023 : https://drees.solidarites-sante.gouv.fr/communique-de-presse-jeux-de-donnees/240725_Data_Base_SAE_2023
#mais prendre les bases statistiques pour faire des statistiques et des études

#bordereau ID
file2 = paste0(path,'ID_2023.csv') 
SAE = read.csv(file2, 
               sep = ";")%>%
  mutate(TEL="")
#bordereau FILTRE
#bordereau DIALYSE
#bordereaux Q20-21-22-23-24 probablement également utiles


# identification dans le bordereau filtre des établissements réalisant une activité exclusive de dialyse