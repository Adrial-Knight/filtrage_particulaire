function X_mean = filtrage_particulaire(init, Z, N, Phi, G, sigma)
% FILTRAGE_PARTICULAIRE - Applique un filtrage particulaire sur un ensemble
% de données de mesures radar
%
% Syntaxe: X_mean = filtrage_particulaire(init, Z, N, Phi, G, sigma)
%
% Entrée:
%   init (4x1 double) - État initial des particules [x; x'; y; y']
%   Z (2xM double)    - Mesures du radar où avec M le nombre de mesures
%   N (1x1 double)    - Nombre de particules à simuler
%   Phi (4x4 double)  - Matrice d'état d'évolution
%   G (4x2 double)    - Matrice d'état du gain du bruit d'état
%   sigma (struct)    - contient les champs (variances) u, r et theta
%
% Sortie:
%   X_mean (4xM double) - Estimations moyennes des particules filtrées
%
% Exemple:
%   X_mean = filtrage_particulaire(init, Z, N, Phi, G, sigma) applique un
%   filtrage de particules sur les données de mesures radar Z en utilisant
%   N particules, la matrice d'état d'évolution Phi, la matrice de gain de
%   bruit G et la variance sigma

    % Initialisation
    X = repmat(init, 1, N);  % ensemble des vecteurs d'etat des particules
    w = 1/N * ones(1, N);    % poids (importance) des particules
    Neff_min = 0.7;          % pourcentage minimal de particules effectives    

    X_mean = zeros(length(Phi), length(Z));  % estimations moyennes

    % Filtrage
    for i = 1:length(Z)
        X = simu_modele_etat(X, Phi, G, sigma.u);
        
        w = w .* vraisemblance(X, Z(:, i), sigma);
        w = w ./ sum(w);
        
        Neff = 1 / sum(w.^2);
        if Neff < Neff_min * N
            [X, w] = resampling(X, w);
        end
        
        X_mean(:, i) = sum(w .* X, 2);
    end
end
