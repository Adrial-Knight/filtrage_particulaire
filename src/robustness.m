%% Initialisation
close all; clear; clc;
addpath("data/", "fonctions/", "fonctions/filtrage/")
load("data/trajectoire_reelle.mat", "Xvrai");
load("data/mesures_radar.mat", "Z");

%% Parametres
% variation de l'initialisation du vecteur d'état (position x)
valspace.init.num    = 10;   % nombre de réalisation pour un point
valspace.init.values = linspace(1500, 8000, 50);   % points à tester

% variation du nombre de particules
valspace.part.num    = 20;   % nombre de réalisation pour un point
valspace.part.values = logspace(1, 3, 50);   % points à tester

% variance des bruits d'état et de mesure
sigma.u = 2;            % m/s^2
sigma.r = 50;           % m
sigma.theta = pi/100;   % radian

T = 1;      % temps d'échantillonage en seconde
N = 1000;   % nombre de particules par défaut

%% Constantes
% Matrice d'etat
Phi = kron(eye(2), [1, T; 0, 1]);  % evolution
G   = kron(eye(2), [T^2/2; T]);    % gain du bruit

% arguments par defauts
arg = struct("init", Xvrai(:, 1), "Xvrai", Xvrai, "Z", Z, "N", N, ...
             "Phi", Phi, "G", G, "sigma", sigma);

%% Simulations
% Variation de l'initialisation
modif_init = @(value, init) [value; init(2:4)];
fprintf("Initialisation: ")
[variations.init, convergence.init] = modif_params(arg, "init", valspace.init, modif_init);
fprintf("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b terminé\n")

% Nombre de particules
fprintf("Nb particules:  ")
modif_N = @(value, N) round(value);
[variations.N, convergence.N] = modif_params(arg, "N", valspace.part, modif_N);
fprintf("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b terminé\n")

%% Sauvegarde
save(get_save_path())

%% Affichage
figure("Position", [200, 150, 940, 480])

% variation de l'initialisation
subplot(221)
plot(valspace.init.values, variations.init, "-b", "MarkerFaceColor", "b")
grid on
xlabel("position x initiale")
ylabel("Erreur quadratique")
title("Erreur d'estimation")

subplot(222)
plot(valspace.init.values, convergence.init, "o")
xlim([valspace.init.values(1), valspace.init.values(end)])
ylim([0, 110])
grid on
xlabel("position x initiale")
ylabel("%")
title("Taux de convergence")

% variation du nombre de particules
subplot(223)
semilogx(valspace.part.values, variations.N, "-b", "MarkerFaceColor", "b")
grid on
xlabel("Nombre de particules")
ylabel("Erreur quadratique")
title("Erreur d'estimation")

subplot(224)
semilogx(valspace.part.values, convergence.N, "o")
ylim([0, 110])
grid on
xlabel("Nombre de particules")
ylabel("%")
title("Taux de convergence")