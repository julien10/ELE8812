im = imread('Voiture.tif');
[M,N,~] = size(im);
imFreq = fft2(im,M*8,N*8);
imFreq = fftshift(imFreq);
imFreq = abs(imFreq);
imFreq = log(imFreq+1);
imFreq = mat2gray(imFreq);
subplot(1,2,1)
imshow(im)
title('Image originale')
subplot(1,2,2)
imshow(imFreq)
title('Image dans le domaine fréquentiel')
axis on

%% Exercice 3
im = imread('Lune2.tif');
[M,N,~] = size(im);
% Paramètres
fc = 5;                    % Fréquence de coupure en pixels
type = 'butter';            % Type du filtre (butter,ideal ou gauss)
pad = 0;                    % Nombre de pixels de padding
ordre = 2;                  % Ordre du filtre
c = 1;                      % Coefficient de masquage

% [ims, HH] = filtpb(im, fc, type, pad, ordre);   % Filtrage passe-bas
% diff = im-ims;              % Différence entre image originale et image filtrée
% imr = im + c*diff;          % Rehaussement

u0 = M/2; v0 = N/2;             % Fréquences nulle
[u,v] = ndgrid(1:M,1:N);
duv = ((u-u0).^2 + (v-v0).^2);
duv = duv/max(max(duv));
laplacien = -4*pi^2*duv;
fuv = fftshift(fft2(im));
fxy = ifft2(ifftshift(laplacien.*fuv));
imr = double(im) + c*abs(fxy);
laplace = [0 -1 0; -1 4 -1; 0 -1 0];
laplacian = imfilter(im,laplace);
ims = im + c*laplacian;
% imr = uint8(imr);

% Affichage
subplot(1,2,1)
imagesc(imr)
title('Image rehaussée fréquentiellement')
axis off;
subplot(1,2,2)
imagesc(ims)
% imshow(imr)
title('Image rehaussée spatialement')
axis off;

