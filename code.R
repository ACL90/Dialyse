
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

na0 = function(a){
  return(ifelse(is.na(a),0,a))
}
#bordereau FILTRE
#bordereau ID
#bordereau DIALYSE
#bordereaux Q20-21-22-23-24 probablement également utiles
#bordereau TELEMED


# identification dans le bordereau filtre des établissements réalisant une activité exclusive de dialyse
file = paste0(path,'FILTRE_2022r.csv') 
queDialyses = read.csv(file, 
               sep = ";")%>%
  filter(IRC==1)%>%
  filter(STATUT=="DECLA")%>%
  mutate(autres = na0(HEB_MED) + 
           na0(HEB_CHIR)+
                 na0(HEB_PERINAT)+
                       na0(HEB_PSY)+
                             na0(HEB_SSR)+
                                   na0(HEB_SLD)+
                                         na0(MED)+
                                               na0(CHIRAMBU)+
                                                     na0(PSY)+
           na0(RTH)+
                 na0(CHIMIO)+
                       na0(IVGAMP)+
                             na0(CPP)+
                                   na0(HAD)+
                                         na0(SSR)+
                                               na0(URG)+
                                                     na0(SMURSAMU))%>%
  filter(autres==0)

#bordereau ID
ID = read.csv("data/ID_2022r.csv", 
              sep = ";")
queDialyses_ID = queDialyses%>%
  select(AN,FI,RS,FI_EJ)%>%
  left_join(ID%>%rename(FI=fi), by = join_by(FI))


#bordereau DIALYSE (sans personnel)
#pour bien comprendre voir AE 2022 Bases statistiques - formats SAS-CSV\Documentation\...
#...SAE2022_Dictionnaire des variables par bordereaux.xlsx
Dialyse = read.csv("data/DIALYSE_2022r.csv", 
              sep = ";")
queDialyses_ID_DIAL = queDialyses_ID%>%
  left_join(Dialyse, by = join_by(FI))


#bordereau DIALYSE (avec personnel)
#pour bien comprendre voir AE 2022 Bases statistiques - formats SAS-CSV\Documentation\...
#...SAE2022_Dictionnaire des variables par bordereaux.xlsx
Dialyse_P = read.csv("data/DIALYSE_P_2022r.csv", 
                     sep = ";") 
queDialyses_ID_DIALP = queDialyses_ID%>%
  left_join(Dialyse_P, by = join_by(FI))


#bordereaux Q21-23
Q21 = read.csv("data/Q21_2022r.csv", 
               sep = ";") 
queDialyses_Q21 = queDialyses_ID%>%
  left_join(Q21, by = join_by(FI))

Q23 = read.csv("data/Q23_2022r.csv", 
               sep = ";") 
queDialyses_Q23 = queDialyses_ID%>%
  left_join(Q23, by = join_by(FI))




