%*************************************************************************%
% Fichier : histogrammes.m
% Description : Script effectuant l'am�lioration d'image de la photo de
%               la Lune.
% Auteurs : Julien ANTOINE 1813026 & Maxime SCHMITT 1719088
%*************************************************************************%

%% Chargement de l'image
im = imread('Lune.tif');
classin = class(im);
im2 = im2double(im);


%% Correction de l'exposition (filtre gamma)

% Param�tre
gamma = 0.3;

% Correction
im3 = im2.^gamma;              % Transformation gamma

% Affichage
figure(1);
subplot(2, 2, 1);
imshow(im2);
title('Image originale');
subplot(2, 2, 2);
imhist(im2);
title('Image originale');
subplot(2, 2, 3);
imshow(im3);
title(['Image apr�s transformation gamma (\gamma = ',num2str(gamma),')']);
subplot(2, 2, 4);
imhist(im3);
title(['Image apr�s transformation gamma (\gamma = ',num2str(gamma),')']);

% Ecriture du fichier
% imwrite(im3,'luneClaire.png');



%% Affinage de l'image

% Param�tres 
sigma = 0.5;                                            % Ecart-type du filtre gaussien
c = 10;                                     			% Coefficient de r�haussement
taille = 2*ceil(2*sigma)+1;                             % Taille du filtre (nombre impair >= 3)

% Affinage
im3floue = imgaussfilt(im3,sigma,'FilterSize',taille);	% Application du filtre gaussien d'�cart type sigma
diff = im3 - im3floue;									% Diff�rence entre l'image originale et l'image floue
im4 = im3 + c * diff;									% Affinage de l'image
im5 = histeq(im4);										% Egalisation de l'histogramme
m = find(imhist(im4)~=0,1,'last');
im6 = im4 .* (256/m);


% Affichage
figure(2);
subplot(2, 2, 1);
imshow(im4);
title('');
subplot(2, 2, 2);
imhist(im4);
title('');
subplot(2, 2, 3);
imshow(im5);
title('');
subplot(2, 2, 4);
imhist(im5);
title('');

% Ecriture du fichier
% imwrite(im4,['netteG',num2str(sigma),'T',num2str(taille),'C',num2str(c),'.png']);


%% �galisation d'histogramme

eval(['ims = im2', classin, '(im);'])