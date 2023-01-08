function theta = fonction_theta(x, y)
% FONCTION_THETA - Calcule la valeur de l'angle entre l'axe de visée et
% l'axe de référence du radar
%
% Syntaxe: theta = fonction_theta(x, y)
%
% Entrée:
%   x (1xn double) - Vecteur colonne de valeurs des positions x de la cible
%   y (1xn double) - Vecteur colonne de valeurs des positions y de la cible
%
% Sortie:
%   theta (1xn double) - Vecteur colonne de valeurs de theta calculées
%
% Exemple:
%   theta = fonction_theta(x, y) calcule la valeur de theta à partir de x
%   et y en utilisant la fonction arctangente.

    theta = atan(y./x);
end
