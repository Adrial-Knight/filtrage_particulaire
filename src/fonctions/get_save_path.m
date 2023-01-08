function save_path = get_save_path()
% GET_SAVE_PATH - Crée un chemin d'accès unique pour un fichier de
% sauvegarde du workspace du fichier appelant.
%
% Syntaxe: save_path = get_save_path()
%
% Sortie:
%   save_path (char) - Chemin d'accès complet au fichier de sauvegarde
%
% Exemple:
%   save_path = obtenir_chemin_sauvegarde() crée un chemin d'accès au
%   fichier de sauvegarde du workspace du fichier appelant nommé
%   "nomDuFichierAppelant_id.mat" dans le dossier "workspaces", où
%   "nomDuFichierAppelant" est le nom du fichier appelant sans son
%   extension et "id" est un identifiant unique ajouté au nom du fichier
%   si un fichier de sauvegarde avec ce nom existe déjà dans le dossier.

    % Création du dossier "workspaces" s'il n'existe pas
    if ~exist("workspaces", 'dir')
        mkdir("workspaces")
    end
    
    % Récupération du nom du fichier appelant la fonction sans extension
    stack = dbstack();
    calling_filename = stack(2).name;
    
    % Création du chemin d'accès complet au fichier de sauvegar
    save_path = fullfile('workspaces', [calling_filename, '.mat']);
    
    % Définition de l'identifiant à ajouter au nom du fichier si besoin
    id = 1;
    
    % Boucle jusqu'à ce que le fichier de sauvegarde soit disponible
    while exist(save_path, 'file') == 2
        % Incrémentation de l'identifiant
        id = id + 1;
        % Mise à jour du chemin d'accès complet au fichier de sauvegarde
        save_path = fullfile('workspaces', [calling_filename, '_', num2str(id), '.mat']);
    end
end

