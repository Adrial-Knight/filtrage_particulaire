function x_next = simu_modele_etat(x, Phi, G, sigma)
% SIMU_MODELE_ETAT - Simule le vecteur d'état suivant d'un système en
% utilisant la matrice d'évolution et le bruit d'état
%
% Syntaxe: x_next = simu_modele_etat(x, Phi, G, sigma)
%
% Entrée:
%   x (4xn double)   - Vecteur d'état actuel [x; x'; y; y']
%   Phi (4x4 double) - Matrice d'évolution de l'état
%   G (4x2 double)   - Matrice de gain du bruit d'état
%   sigma (double)   - Écart-type du bruit d'état
%
% Sortie:
%   x_next (4xn double) - Vecteur d'état simulé suivant
%
% Exemple:
%   x_next = simu_modele_etat(x, Phi, G, sigma) simule le vecteur d'état
%   suivant du système défini par x, Phi, G et sigma en utilisant un bruit
%   d'état généré aléatoirement selon l'écart-type sigma.

    x_next = Phi * x + G * sigma * randn(2, length(x));
end
