% 1) Carregando o áudio original
load handel.mat;  % contém y e Fs
sound(y, Fs);
pause(2);
fprintf('Áudio original carregado. Duração: %.2f segundos\n', length(y)/Fs);

% 2) Calculando a DCT do sinal
Y = dct(y);

% 3) Definindo os valores de energia que queremos manter
energy_ratios = [0.995, 0.99, 0.90, 0.75, 0.50];

% Loop para testar diferentes níveis de compressão
for e = 1:length(energy_ratios)
    energy_ratio = energy_ratios(e);

    % --- Encontrando os coeficientes mais energéticos ---
    [~, ind] = sort(abs(Y), 'descend'); % índices ordenados por magnitude
    i = 1;
    
    % Encontrando o número mínimo de coeficientes que concentram 'energy_ratio' da energia total
    while (norm(Y(ind(1:i))) / norm(Y))^2 < energy_ratio
        i = i + 1;
    end
    needed = i;
    
    % --- Criando a DCT comprimida ---
    Y2 = zeros(size(Y));
    Y2(ind(1:needed)) = Y(ind(1:needed));
    
    % --- Reconstruindo o sinal comprimido ---
    y_rec = idct(Y2);
    
    % --- Exibindo resultados numéricos ---
    perc_coef = 100 * needed / length(Y);
    fprintf('%.2f%% da energia ? %d coeficientes (%.2f%% do total)\n', ...
        100*energy_ratio, needed, perc_coef);
    
    % --- Plotando o sinal original e o comprimido ---
    figure;
   
    
    plot(y, 'LineWidth', 1.5); hold on;
    plot(y_rec, 'LineWidth', 1.5);
    xlabel('$n$', 'FontName', 'times new roman', 'FontSize', 20, 'Interpreter', 'latex');
    ylabel('$x[n]$', 'FontName', 'times new roman', 'FontSize', 20, 'Interpreter', 'latex');
    set(gca, 'FontName', 'times new roman', 'FontSize', 20);
    legend({'Original', ['Comprimido com $N_s = ' num2str(needed) '$']}, ...
        'Interpreter', 'latex', 'Location', 'southeast');
    title(['Compressão DCT - ', num2str(100*energy_ratio), '% da energia mantida']);
    
    % --- Reprodução do som comprimido ---
    sound(y_rec, Fs);
    pause(2);
end