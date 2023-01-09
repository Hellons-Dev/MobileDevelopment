# !!!!!
```diff 
! Attention ! Cette branche est exploitable mais n'est utilisé 
! qu'à titre d'historique d'étape du projet. 
! Pour obtenir la dernière version du projet, 
! veuillez vous rendre dans la branche "Final-Project" 
```

# MobileDevelopment

## Description du projet

Le projet de développement mobile et un projet visant à créer une application sous IOS réalisant l'affichage du planning d'un évènement sur deux jours : le 08 et le 09 Février 2023.
Pour cela le cahier des charge suivant nous as été transmis :
+ L'application doit être codé en SWIFT UI
+ Sur la "Home Page" doivent se trouver les évènements du premier jour
+ Chaque évènement doit disposé d'une page de détail.

Pour complété ce cahier des charges nous avons accès a une API regroupant les différentes données tel que :
+ Les noms des évènements
+ Leurs programmation
+ Les salles
+ Les présentateurs
+ Les notes liés aux évènements

## Travail réalisé sur cette branche

Sur cette branche se trouve la toute premiere version exploitable du projet SWIFT sous XCODE.

Cette tout première version avait pour but la mise en place des view du projet ainsi que des fonctionnalitées respectueuse du cahier des charges attibué.

Cette branche contient donc un fichier principal intitulé "Project" dans lequel se trouve le projet XCODE respectueux du cahier des charge et entierement fonctionnel.
Dans cette version nous avons mis en place de multiple view dont un view automatique utilisé en première view réalisant la fonction d'écran de chargement et récupérant les informations de l'API ainsi que la réalisation des fonctions de triage des données par ordre date et heure ainsi que la fonction de formattage des données de date et heure.
Cette version comprend donc un écran de chargement qui lorsque les données sont reçu, adaptées et trier, passe directement à la "Home Page" sur laquelle se trouves le planning du premier jour de l'évènement ainsi qu'un bouton schedule redirigant vers la page contenant la liste de tout les évènements répartis sur les deux jours avec possibilité de cliquer sur chacuns d'entre eux pour obtenir leurs détails.
