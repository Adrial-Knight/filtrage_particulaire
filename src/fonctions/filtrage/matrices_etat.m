function [Phi, G] = matrices_etat(T)
% MATRICE_ETAT - Calcule les matrices d'état pour le filtrage de Kalman.
%
% Syntaxe :   [Phi, G] = matrices_etat(T)
%
% Entrée :
%   T   - Intervalle de temps entre deux mesures (en secondes)
%
% Sortie :
%   Phi - Matrice d'évolution de l'état
%   G   - Matrice de gain de bruit
%
% Exemple :
%   [Phi, G] = matrices_etat(0.1)

    Phi = kron(eye(2), [1, T; 0, 1]);
    G   = kron(eye(2), [T^2/2; T]);
end
