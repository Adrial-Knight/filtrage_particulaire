function [errors, convergence] = modif_params(params, to_modif, valspace, func_modif)
% MODIF_PARAMS - Modifie les paramètres du système pour calculer les
% erreurs et le taux de convergence du filtrage particulaire
%
% Syntaxe: [errors, convergence] = modif_params(params, to_modif, valspace, func_modif)
%
% Entrée:
%   params (struct)   - Struct contenant les paramètres du système
%   to_modif (char)   - Nom du paramètre à modifier
%   valspace (struct) - Struct contenant les champs suivants:
%       valspace.values (1xn double) - Valeurs de modification à tester
%       valspace.num (double)        - Nombre de simulations à effectuer    
%                                      pour chaque valeur
%   func_modif (function handle) - Fonction de modification du paramètre
%
% Sortie:
%   errors (1xn double)      - Erreurs moyennes du système modifié pour
%                              chaque valeur de modification testée
%   convergence (1xn double) - Taux de convergence du système modifié pour
%                              chaque valeur de modification testée (en %)
%
% Exemple:
%   [variations, convergeance] = modif_params(params, 'G', valspace, @(x,y) x*y)
%   modifie le paramètre 'G' du système params en multipliant sa valeur par
%   chaque valeur de valspace.values, effectue valspace.num simulations
%   pour chaque valeur de modification et calcule les erreurs moyennes et
%   le taux de convergence du système modifié pour chaque valeur.
    
    valspace.pts = length(valspace.values);
    convergence = zeros(1, valspace.pts);
    errors = NaN(1, valspace.pts);
    p = params;

    fprintf("calcul en cours... 00%%")
    for i_pts = 1:valspace.pts
        p.(to_modif) = func_modif(valspace.values(i_pts), params.(to_modif));
        error = 0;
        for i_num = 1:valspace.num
            X = filtrage_particulaire(p.init, p.Z, p.N, p.Phi, p.G, p.sigma);
            if all(~isnan(X))
                error = error + norm([X(1, :) - p.Xvrai(1, :), X(3, :) - p.Xvrai(3, :)]);
                convergence(i_pts) = convergence(i_pts) + 1;
            end
        end
        if convergence(i_pts) > 0
            errors(i_pts) = error / convergence(i_pts);
            convergence(i_pts) = 100 * convergence(i_pts) / valspace.num;
        end
        fprintf("\b\b\b%02d%%", min(99, round(i_pts/valspace.pts*100)))
    end
    fprintf(repmat('\b', 1, 16) + " terminé\n")
end
