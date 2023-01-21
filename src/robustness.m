%% Initialisation
close all; clear; clc; dbstop if error;
addpath("data/", "fonctions/", "fonctions/filtrage/")
load("data/trajectoire_reelle.mat", "Xvrai");
Z.non_bruite = load("data/mesures_radar_non_bruitees.mat").Z;
Z.bruit      = load("data/mesures_radar.mat", "Z").Z;

%% Parametres
% variance des bruits d'état et de mesure
sigma.u = 2;            % m/s^2
sigma.r = 50;           % m
sigma.theta = pi/100;   % radian

T = 1;      % temps d'échantillonage en seconde
N = 1000;   % nombre de particules par défaut

% variation de l'initialisation du vecteur d'état (position x)
valspace.init.num    = 10;   % nombre de réalisation pour un point
valspace.init.values = linspace(1500, 8000, 50);   % points à tester

% variation du nombre de particules
valspace.part.num    = 10;   % nombre de réalisation pour un point
valspace.part.values = linspace(10, 1000, 50);   % points à tester

% écart-type des bruits de mesure
valspace.mesure.num = 10;    % nombre de réalisation pour un point
valspace.mesure.r.values = linspace(0, sigma.r, 20);
valspace.mesure.theta.values = linspace(0, sigma.theta, 20);

% écart-type des bruits de modele
valspace.modele.num = 10;
valspace.modele.values = linspace(0, 200, 50);

%% Constantes
% Matrice d'etat
Phi = kron(eye(2), [1, T; 0, 1]);  % evolution
G   = kron(eye(2), [T^2/2; T]);    % gain du bruit

%% Simulations sur les données radar bruitées
% arguments par defauts
arg = struct("init", Xvrai(:, 1), "Xvrai", Xvrai, "Z", Z.bruit, "N", N, ...
             "Phi", Phi, "G", G, "sigma", sigma);

% Variation de l'initialisation
fprintf("Initialisation:  ")
modif_init = @(value, init) [value; init(2:4)];
[variations.init, convergence.init] = modif_params(arg, "init", valspace.init, modif_init);

% Nombre de particules
fprintf("Nb particules:   ")
modif_N = @(value, N) round(value);
[variations.N, convergence.N] = modif_params(arg, "N", valspace.part, modif_N);

%% Simulations sur les données radars non bruitées
% arguments par defauts
arg = struct("init", Xvrai(:, 1), "Xvrai", Xvrai, "Z", Z.non_bruite, ...
             "N", N, "Phi", Phi, "G", G, "sigma", sigma);

% Bruits de mesure
fprintf("Ecart-type mesure: ")
variations.mesure = modif_data_radar(arg, valspace.mesure);

% Bruit de modele
fprintf("Ecart-type modele: ")
modif_modele = @(value, sigma) struct("u", value, "r", sigma.r, "theta", sigma.theta);
[variations.modele, convergence.modele] = modif_params(arg, "sigma", valspace.modele, modif_modele);

%% Sauvegarde
save(get_save_path())

%% Affichage
set(groot, 'defaultAxesFontSize', 11);
plot_("Position x initiale",  valspace.init.values,   variations.init,   convergence.init, "pos_x_init")
plot_("Nombre de particules", valspace.part.values,   variations.N,      convergence.N, "nb_part")
plot_("\sigma_{modele}",    valspace.modele.values, variations.modele, convergence.modele, "sigma2model")

% variation des ecart types des bruit de mesure
set(groot, 'defaultAxesFontSize', 9);
figure("Name", "Variation des écart types de bruit de mesure")
imagesc(valspace.mesure.r.values, valspace.mesure.theta.values, variations.mesure);
% title("Erreur d'estimation")
xlabel("\sigma_r"); ylabel("\sigma_{\theta}")
colorbar
exportgraphics(gca, "../fig/robustness/" + "vars_error" + ".pdf")

function plot_(x_label, values, variations, convergences, filename)
    set(groot, 'defaultAxesFontSize', 11);
    figure("Name", x_label, "Position", [200, 150, 940, 300])
    subplot(121)
    plot(values, variations, "-b", "MarkerFaceColor", "b")
    grid on
    xlabel(x_label)
    ylabel("||.||_2")
    if isstring(filename)
        exportgraphics(gca, "../fig/robustness/" + filename + "_error" + ".pdf")
    else
        title("Erreur d'estimation")
    end
    
    subplot(122)
    plot(values, convergences, "o")
    ylim([0, 110])
    grid on
    xlabel(x_label)
    ylabel("%")
    if isstring(filename)
        exportgraphics(gca, "../fig/robustness/" + filename + "_convg" + ".pdf")
    else
        title("Taux de convergence")
    end
end
