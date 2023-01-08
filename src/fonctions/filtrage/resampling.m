function [Xr, wr]=resampling(X,w)
% RESAMPLING - Rééchantillonne un ensemble de particules selon leurs poids
%
% Syntaxe: [Xr, wr] = resampling(X, w)
%
% Entrée:
%   X (dxn double) - Tableau contenant les particules à rééchantillonner,
%                    où X(:,k) est un vecteur colonne correspondant à la
%                    kième particule
%   w (1xn double) - Vecteur contenant les poids associés aux particules,
%                    où w(k) est le poids de la kième particule
%
% Sortie:
%   Xr (dxn double) - Tableau des particules après rééchantillonnage,
%                     où Xr(:,k) est un vecteur colonne correspondant à
%                     la kième particule
%   wr (1xn double) - Vecteur contenant les poids après rééchantillonnage,
%                     où wr(k) est le poids de la kième particule
%
% Exemple:
%   [Xr, wr] = resampling(X, w) rééchantillonne l'ensemble de particules X
%   selon leurs poids w en utilisant l'algorithme de rééchantillonnage par
%   tirage aléatoire stratifié. Les particules rééchantillonnées sont
%   stockées dans Xr et leurs poids dans wr. Toutes les particules
%   rééchantillonnées ont le même poids.


N1=size(X,2);
N2=N1;

ind_select = zeros(1,N2);

% sample the particles 
N_sons=zeros(1,N1);
dist=cumsum(w);

aux=rand(1);
u=aux:1:(N2-1+aux);
u=u./N2;

% sélection des particules à rééchantillonner
j=1;
for i=1:N2
   while (u(1,i)>=dist(1,j))
      j=j+1;
   end
   N_sons(1,j)=N_sons(1,j)+1;
end

% remplissage de ind_select avec les indices des particules sélectionnées
ind=1;
for i=1:N1
   % if copy then keep it here
   if (N_sons(1,i)>0)
      for j=ind:ind+N_sons(1,i)-1
         ind_select(j) = i;
      end
      
   end
   
   ind=ind+N_sons(1,i);
end

% construction des tableaux Xr et wr à partir des particules sélectionnées
Xr = X(:,ind_select);
wr = ones(1,N2)/N2;
