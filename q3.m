% 1. Ler a imagem
img = imread('sosias.jpg');

% Converter para escala de cinza (caso a imagem seja colorida)
if size(img, 3) == 3
    img = rgb2gray(img);
end

% 2. Calcular a DCT 2D
dct_img = dct2(double(img));

% 3. Calcular a energia da imagem (magnitude da DCT)
energia = log(1 + abs(dct_img));

% 4. Exibir os resultados
figure;

subplot(1,2,1);
imshow(img, []);
title('Imagem Original');

subplot(1,2,2);
imshow(energia, []);
title('Energia da Imagem (DCT)');
