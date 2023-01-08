function r = fonction_r(x, y)
% FONCTION_R - Calcule la valeur de r à partir de x et y
%
% Syntaxe: r = fonction_r(x, y)
%
% Entrée:
%   x (1xn double) - Vecteur colonne de valeurs des positions x
%   y (1xn double) - Vecteur colonne de valeurs des positions y
%
% Sortie:
%   r (1xn double) - Vecteur colonne des distances r à la cible
%
% Exemple:
%   r = fonction_r(x, y) calcule la distance à la cible avec la norme 2.

    r = vecnorm([x; y], 2);
end
