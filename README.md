# !!!!!
```diff 
- Attention ! Cette branche n'est pas exploitable et n'est utilisé 
- qu'à titre d'historique d'étape du projet. 
- Pour obtenir la dernière version du projet, 
- veuillez vous rendre dans la branche "Final-Project" 
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

Sur cette branche se trouve la premiere version de la mise en place d'une interface d'affichage du planning sur le projet SWIFT de XCODE ainsi que les différents test playground réalisé pour corriger les appels réseaux ainsi que la mise en place de fonction de modification des formats de dates et heures des données
Cette version **_non exploitable_** avait pour but la mise en place de la première version de l'interface d'affichage et l'adaptation des codes de formatage d'heure.

Cette branche contient donc trois fichier principaux :
- Le fichier "Project" dans lequel se trouve le projet XCODE.
- Le fichier "test.playground" dans lequel se trouve les tests d'appel réseau corrigés.
- Le fichier "Lastest 2" étant un projet de test SWIFT sous XCODE visant à tester la mise en place de codes d'adaptation des formats de dates et d'heures

Dans cette version seuls les appels réseaux corrigés fonctionnent et les tests de formatage de date et heure n'était pas concluant car il y avait des conflits entre les fonction synchrones et l'appel réseau asynchrone
