function [Xr, wr]=resampling(X,w)
% RESAMPLING - R��chantillonne un ensemble de particules selon leurs poids
%
% Syntaxe: [Xr, wr] = resampling(X, w)
%
% Entr�e:
%   X (dxn double) - Tableau contenant les particules � r��chantillonner,
%                    o� X(:,k) est un vecteur colonne correspondant � la
%                    ki�me particule
%   w (1xn double) - Vecteur contenant les poids associ�s aux particules,
%                    o� w(k) est le poids de la ki�me particule
%
% Sortie:
%   Xr (dxn double) - Tableau des particules apr�s r��chantillonnage,
%                     o� Xr(:,k) est un vecteur colonne correspondant �
%                     la ki�me particule
%   wr (1xn double) - Vecteur contenant les poids apr�s r��chantillonnage,
%                     o� wr(k) est le poids de la ki�me particule
%
% Exemple:
%   [Xr, wr] = resampling(X, w) r��chantillonne l'ensemble de particules X
%   selon leurs poids w en utilisant l'algorithme de r��chantillonnage par
%   tirage al�atoire stratifi�. Les particules r��chantillonn�es sont
%   stock�es dans Xr et leurs poids dans wr. Toutes les particules
%   r��chantillonn�es ont le m�me poids.


N1=size(X,2);
N2=N1;

ind_select = zeros(1,N2);

% sample the particles 
N_sons=zeros(1,N1);
dist=cumsum(w);

aux=rand(1);
u=aux:1:(N2-1+aux);
u=u./N2;

% s�lection des particules � r��chantillonner
j=1;
for i=1:N2
   while (u(1,i)>=dist(1,j))
      j=j+1;
   end
   N_sons(1,j)=N_sons(1,j)+1;
end

% remplissage de ind_select avec les indices des particules s�lectionn�es
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

% construction des tableaux Xr et wr � partir des particules s�lectionn�es
Xr = X(:,ind_select);
wr = ones(1,N2)/N2;
