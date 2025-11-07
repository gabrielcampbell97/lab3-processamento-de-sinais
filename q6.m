%% QUESTÃO 6 - Compressão de imagem usando energy_ratio

% 1) Ler imagem e converter para escala de cinza
img = imread('sosias.jpg');
img_gray = rgb2gray(img);
A = double(img_gray);

% 2) Calcular DCT 2D
D = dct2(A);

% 3) Definir níveis de energia desejados
energy_ratios = [0.995, 0.99, 0.90, 0.75, 0.50];

% 4) Ordenar coeficientes da DCT por magnitude
[sortedVals, ind] = sort(abs(D(:)), 'descend');

for e = 1:length(energy_ratios)
    energy_ratio = energy_ratios(e);

    % Calcular número de coeficientes necessários
    i = 1;
    while (norm(sortedVals(1:i)) / norm(sortedVals))^2 < energy_ratio
        i = i + 1;
    end
    needed = i;
    
    % Criar matriz DCT comprimida
    D2 = zeros(size(D));
    [row, col] = ind2sub(size(D), ind(1:needed));
    for k = 1:needed
        D2(row(k), col(k)) = D(row(k), col(k));
    end
    
    % Reconstruir imagem comprimida
    A_rec = idct2(D2);
    
    % Mostrar resultados
    figure;
    imshow(uint8(A_rec));
    title(['Imagem comprimida - ', num2str(100*energy_ratio), '% da energia mantida']);
    
    % Calcular percentual de coeficientes usados
    perc_coef = 100 * needed / numel(D);
    fprintf('%.2f%% da energia ? %d coeficientes (%.2f%% do total)\n', ...
        100*energy_ratio, needed, perc_coef);
end

