function p = vraisemblance(x, z, sigma)
% VRAISSEMBLANCE - Calcule la vraisemblance entre observations et modèle
%
% Syntaxe: p = vraisemblance(x, z, sigma)
%
% Entrée:
%   x (4xn double) - Vecteur d'état [x; x'; y; y']
%   z (2xn double) - Observations [r; theta]
%   sigma (struct) - Ecart-type avec les champs r et theta
%
% Sortie:
%   p (1xn double) - Vraisemblance entre les observations et le modèle
%
% Exemple:
%   p = vraisemblance(x, z, sigma) calcule la vraisemblance entre les
%   observations z et le modèle défini par le vecteur d'état x en utilisant
%   les variances de r et de theta définies dans sigma. La vraisemblance
%   est calculée en multipliant la densité de probabilité des observations.

    p_vrai = @(m, o, s) 1/(sqrt(2*pi)*s) * exp(-1/(2*s^2)*(o-m).^2);    

    p_r     = p_vrai(fonction_r(x(1, :), x(3, :)),     z(1), sigma.r);
    p_theta = p_vrai(fonction_theta(x(1, :), x(3, :)), z(2), sigma.theta);

    p = p_r .* p_theta;
end
