function ims = mae_bil(im, sc)
% 
% Fonction effectuant le changement d'�chelle de l'image im selon le 
% facteur sc, interpolation bilin�aire.
% 
% Param�tres d'entr�e : 
% im : image (niveaux de gris) d'un type reconnu par Matlab. Tableau 2D 
% sc : param�tre de changement d'�chelle. R�el strictement positif 
% 
% Param�tre de sortie : 
% ims : image � la nouvelle �chelle, de m�me type que im 
% 

% Test sur la validit� des param�tres d'entr�e

ims = [];

if sc <= 0
    disp('scale : le param�tre d''�chelle doit �tre > 0')
    return
end

if ndims(im) ~= 2
    disp('scale : l''image doit �tre un tableau � deux dimensions')
    return
end

classin = class(im);

% Pr�servation de l'�chelle

if isinteger(im)
    A = mat2gray(im, double([intmin(classin) intmax(classin)]));
else
    A = mat2gray(im);
end

[M, N] = size(A);

Ms = round(M*sc); % Taille de l'image mise � l'�chelle ims
Ns = round(N*sc); %

xs = (1:Ms)' - 1/2; % Coordonn�es des pixels de ims
ys = (1:Ns) - 1/2; % 

xsp = xs * M / Ms; % Coordonn�es des pixels de ims
ysp = ys * N / Ns; % ramen�es dans le rep�re de l'image de d�part

xisp = floor(xsp)+1; % points (x, y) utilis�s pour l'interpolation
yisp = floor(ysp)+1; %

As = A(xisp, yisp);

eval(['ims = im2', classin, '(As);'])



