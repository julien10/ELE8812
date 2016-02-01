function ims = mae_bil(im, sc)
% 
% Fonction effectuant le changement d'échelle de l'image im selon le 
% facteur sc, interpolation bilinéaire.
% 
% Paramètres d'entrée : 
% im : image (niveaux de gris) d'un type reconnu par Matlab. Tableau 2D 
% sc : paramètre de changement d'échelle. Réel strictement positif 
% 
% Paramètre de sortie : 
% ims : image à la nouvelle échelle, de même type que im 
% 

% Test sur la validité des paramètres d'entrée

ims = [];

if sc <= 0
    disp('scale : le paramètre d''échelle doit être > 0')
    return
end

if ndims(im) ~= 2
    disp('scale : l''image doit être un tableau à deux dimensions')
    return
end

classin = class(im);

% Préservation de l'échelle

if isinteger(im)
    A = mat2gray(im, double([intmin(classin) intmax(classin)]));
else
    A = mat2gray(im);
end

[M, N] = size(A);

Ms = round(M*sc); % Taille de l'image mise à l'échelle ims
Ns = round(N*sc); %

xs = (1:Ms)' - 1/2; % Coordonnées des pixels de ims
ys = (1:Ns) - 1/2; % 

xsp = xs * M / Ms; % Coordonnées des pixels de ims
ysp = ys * N / Ns; % ramenées dans le repère de l'image de départ

xisp = floor(xsp)+1; % points (x, y) utilisés pour l'interpolation
yisp = floor(ysp)+1; %

As = A(xisp, yisp);

eval(['ims = im2', classin, '(As);'])



