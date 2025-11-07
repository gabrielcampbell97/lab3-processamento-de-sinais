%% QUESTÃO 5 - Cálculo da DCT 2D e energia da imagem
clc; clear; close all;

% 1) Ler a imagem
img = imread('sosias.jpg');
img_gray = rgb2gray(img);
imshow(img_gray);
title('Imagem original em tons de cinza');

% 2) Calcular DCT 2D
D = dct2(double(img_gray));

% 3) Calcular energia total
energy_total = norm(D, 'fro')^2;

fprintf('Energia total da imagem: %.2e\n', energy_total);

% 4) Exibir imagem da DCT (em escala log)
figure;
imshow(log(abs(D) + 1), []);
title('Espectro da DCT 2D da imagem');
colormap(jet); colorbar;