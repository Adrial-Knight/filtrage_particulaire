%% Init
close all; clear; clc;
addpath("data/", "fonctions/", "fonctions/filtrage/")
load("data/trajectoire_reelle.mat", "Xvrai");
load("data/mesures_radar.mat", "Z");

%% Parametres
sigma.u = 2;            % m/s^2
sigma.r = 50;           % m
sigma.theta = pi/100;   % radian

T = 1;       % s
N = 1000;   % nombre de particules

%% Constantes
% Matrice d'etat
Phi = kron(eye(2), [1, T; 0, 1]);  % evolution
G   = kron(eye(2), [T^2/2; T]);    % gain du bruit

%% Filtrage
X_mean = filtrage_particulaire(Xvrai(:, 1), Z, N, Phi, G, sigma);

%% Affichage
figure
hold all
grid on
plot(X_mean(1, :), X_mean(3, :))
plot(Xvrai(1, :), Xvrai(3, :))
