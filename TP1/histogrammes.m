%% Chargement de l'image
im = imread('Lune.tif');
classin = class(im);
im = im2double(im);


%% Correction de l'exposition (filtre gamma)

% Paramètre
gamma = 0.3;

% Correction
im3 = im2.^gamma;	% Transformation gamma

% Affichage
subplot(1, 2, 1);
imshow(im2);
title('Image originale')
% subplot(2, 2, 2);
% imhist(im2);
% title('Image originale')
subplot(1, 2, 2);
imshow(im3);
title(['Image après transformation gamma (\gamma = ',num2str(gamma),')'])
% subplot(2, 2, 4);
% imhist(im3);
% title(['Image après transformation gamma (\gamma = ',num2str(gamma),')'])

% Ecriture du fichier
% imwrite(im3,'luneClaire.png');



%% Affinage de l'image

% Paramètres 
sigma = 0.5;		% Ecart-type du filtre gaussien
c = 10;			% Coefficient de réhaussement
taille = 2*ceil(2*sigma)+1;		% Taille du filtre (nombre impair >= 3)

% Affinage
im3floue = imgaussfilt(im3,sigma,'FilterSize',taille);	% Application du filtre gaussien d'écart type sigma
diff = im3 - im3floue;									% Différence entre l'image originale et l'image floue
im4 = im3 + c * diff;									% Affinage de l'image
im5 = histeq(im4);										% Egalisation de l'histogramme
m = find(imhist(im4)~=0,1,'last');
im6 = im4 .* (256/m);


% Affichage
% subplot(1, 2, 1);
% imshow(im4)
% imhist(im4)
% subplot(1, 2, 2);
% imshow(im5)
imhist(im5)

% Ecriture du fichier
% imwrite(im4,['netteG',num2str(sigma),'T',num2str(taille),'C',num2str(c),'.png']);


%% Égalisation d'histogramme

eval(['ims = im2', classin, '(im);'])