% 2. Compressão DCT
y_dct = dct(y);  % Transformada DCT do sinal

percentuais = [99.5, 99.0, 90.0, 75.0, 50.0];
N = length(y_dct);

for p = percentuais
    % Calcula o número de coeficientes mantidos
    n_keep = round(N * (p / 100));
    
    % Mantém apenas os maiores coeficientes em magnitude
    [~, idx] = sort(abs(y_dct), 'descend');
    mask = zeros(size(y_dct));
    mask(idx(1:n_keep)) = 1;
    y_dct_comp = y_dct .* mask;
    
    % Reconstrói o sinal
    y_rec = idct(y_dct_comp);
    
    % Exibição
    figure;
    subplot(2,1,1);
    plot(y);
    title('Sinal Original');
    
    subplot(2,1,2);
    plot(y_rec);
    title(['Sinal Comprimido DCT - ', num2str(p), '% dos coeficientes mantidos']);
    
    % Reproduz o áudio
    sound(y_rec, Fs);
    pause(2);
    
    % Mostra compressão
    fprintf('DCT - %.1f%% mantido ? %d coeficientes\n', p, n_keep);
end