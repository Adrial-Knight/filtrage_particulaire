# Filtrage particulaire appliqué aux mesures d'un radar

Ce dépôt contient le TP réalisé dans le cadre de l'étude du filtrage particulaire appliqué aux mesures d'un radar ciblant un avion.

## Structure du dépôt
Le dépôt se compose de deux dossiers :
- `docs` : contient le sujet et le rapport ce travail
- `src` : contient les codes MATLAB utilisés et développés

## Utilisation du code
Pour utiliser le code contenu dans ce dépôt, vous aurez uniquement besoin d'une installation de MATLAB. Aucune toolbox additionelle n'est nécessaire. \
Deux scripts sont fournis:
- [single_bootstrap](https://github.com/Adrial-Knight/filtrage_particulaire/blob/main/src/single_bootstrap.m): réalise le filtrage particulaire sur les données fournies dans `src/data` et affiche le résultat
- [robustness](https://github.com/Adrial-Knight/filtrage_particulaire/blob/main/src/robustness.m): étudie la robustesse du filtrage en biaisant les paramètres initiaux

## Liens utiles
- [Wiki sur le filtrage particulaire](https://fr.wikipedia.org/wiki/Filtre_particulaire)
- [Documentation de MATLAB](https://www.mathworks.com/help/matlab/)
