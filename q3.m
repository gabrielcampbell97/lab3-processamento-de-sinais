%% QUESTÃO 3 - Compressão de Áudio com FFT usando energy_ratio
clc; clear; close all;

% 1) Carregar o sinal de áudio
load handel.mat;  % contém y e Fs
sound(y, Fs);
pause(2);

% 2) Calcular FFT
Y = fft(y);

% 3) Níveis de energia desejados
energy_ratios = [0.995, 0.99, 0.90, 0.75, 0.50];

for e = 1:length(energy_ratios)
    energy_ratio = energy_ratios(e);

    % Ordenar coeficientes por magnitude
    [~, ind] = sort(abs(Y), 'descend');
    i = 1;

    % Encontrar quantos coeficientes mantêm 'energy_ratio' da energia total
    while (norm(Y(ind(1:i))) / norm(Y))^2 < energy_ratio
        i = i + 1;
    end
    needed = i;

    % Criar sinal comprimido
    Y2 = zeros(size(Y));
    Y2(ind(1:needed)) = Y(ind(1:needed));
    y_rec = real(ifft(Y2));

    % Exibir resultados
    perc_coef = 100 * needed / length(Y);
    fprintf('FFT ? %.2f%% da energia ? %d coeficientes (%.2f%% do total)\n', ...
        100*energy_ratio, needed, perc_coef);

    % Plot
    figure;
    plot(y, 'LineWidth', 1.5); hold on;
    plot(y_rec, 'LineWidth', 1.5);
    xlabel('$n$', 'FontSize', 20, 'Interpreter', 'latex');
    ylabel('$x[n]$', 'FontSize', 20, 'Interpreter', 'latex');
    title(['FFT - ', num2str(100*energy_ratio), '% da energia mantida']);
    legend({'Original', 'Comprimido'}, 'Interpreter', 'latex', 'Location', 'southeast');
    
    sound(y_rec, Fs);
    pause(2);
end


