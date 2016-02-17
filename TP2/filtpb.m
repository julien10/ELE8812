function [ims, HH] = filtpb(im, fc, type, pad, ordre) 
% 
% Fonction effectuant le filtrage passe-bas d'une image
%
% Param�tres d'entr�e : 
% im : image (niveaux de gris) d'un type reconnu par Matlab. Tableau 2D 
% fc : fr�quence de coupure, en nombre de pixels "fr�quentiels". Doit �tre
%      positive
% type : type du filtre
%        'butter' : filtre de butterworth
%        'ideal' : id�al
%        'gauss' : gaussien
% pad : Nombre de pixels de padding de l'image
% ordre : ordre du filtre, si n�cessaire. Defaut : 2
% 
% Param�tre de sortie : 
% ims : image filtr�e, de m�me taille et de m�me type que A
% HH : RF du filtre utilis�
%

% Test sur la validit� des param�tres d'entr�e

ims = [];
HH = [];

if ~ exist('pad', 'var') | isempty(pad)
    pad = 0;
end

if ~ exist('ordre', 'var') | isempty(ordre)
    ordre = 2;
end

if ordre < 2
    disp('filtpb : l''ordre du filtre, si pr�cis� doit �tre > 1')
    return
end

if pad < 0
    disp('filtpb : le param�tre "pad" doit �tre positif ou nul')
    return
end

if fc <= 0
    disp('filtpb : la fr�quence de coupure doit �tre > 0')
    return
end

if ndims(im) ~= 2
    disp('filtpb : l''image doit �tre un tableau � deux dimensions')
    return
end

classin = class(im);
A = double(im);

[M, N] = size(A);
M1 = M + pad;
N1 = N + pad;

AA = fftshift(fft2(A, M1, N1));
M0 = ceil((M1+1) / 2);
N0 = ceil((N1+1) / 2);

[U, V] = ndgrid(1:M1, 1:N1);
D2 = (U - M0).^2 + (V - N0).^2;

switch lower(type)
    case 'butter'
        HH = 1 ./ (1 + (D2 / fc^2).^ordre);
        
    case 'ideal'
        HH = D2 <= fc^2;
        
    case 'gauss'
        HH = exp(-D2 / (2*fc^2));
        
    otherwise
        disp('filtpb : type de filtre non reconnu')
        return
end

BB = ifftshift(AA .* HH);
if ~ isrealimage(BB)
    disp('filtpb : mauvaises dimensions ; certaines images seront complexes')
end

B = ifft2(BB);

eval(['ims = ', classin, '(B(1:M, 1:N));'])
        
return
