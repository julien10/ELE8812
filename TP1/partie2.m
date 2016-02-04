%*************************************************************************%
% Fichier : partie2.m                                                     %
% Description : Script effectuant une réduction puis augmentation         %
%               d'échelle sur l'image Barbara.tif avec les 2 méthodes.    %
% Auteurs : Julien ANTOINE 1813026 & Maxime SCHMITT 1719088               %
% Date : 03/02/2016                                                       %
%*************************************************************************%

clear all;
close all;
clc;

%% Chargement de l'image et définition des paramètres
im = imread('Barbara.tif');
%im2 = im2double(im);

facteurEchelle = 0.5;

%% Changements d'échelle successif utilisant les 2 méthodes

% Avec l'interpolation bilinéaire
imBil = mae_bil(im, 0.5);
imBil = mae_bil(imBil, 2);

% Avec l'interpolation Plus Proche Voisin
imPpv = mae_ppv(im, 0.5);
imPpv = mae_ppv(imPpv, 2);

imwrite(imBil, 'BarbaraBil.tif');
imwrite(imPpv, 'BarbaraPpv.tif');

% Affichage vis-à-vis des images
figure(1);
subplot(1, 2, 1);
imshow(imBil);
title('Interpolation bilinéaire');
subplot(1, 2, 2);
imshow(imPpv);
title('Interpolation Plus Proche Voisin');