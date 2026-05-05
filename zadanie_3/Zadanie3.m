czestotliwosc_sygnalu = 5;
amplituda = 1;
czas_ciagly = 0:0.0001:1;
czestotliwosc_probkowania = 50;
okres_probkowania = 1/czestotliwosc_probkowania;
czas_dyskretny = 0:okres_probkowania:1;

% WARIANT A: Sinusoidalny
%sygnal_ciagly = amplituda * sin(2*pi*czestotliwosc_sygnalu*czas_ciagly); 
%sygnal_dyskretny = amplituda * sin(2*pi*czestotliwosc_sygnalu*czas_dyskretny); 

%WARIANT B: Prostokątny
sygnal_ciagly = amplituda * square(2*pi*czestotliwosc_sygnalu*czas_ciagly); 
sygnal_dyskretny = amplituda * square(2*pi*czestotliwosc_sygnalu*czas_dyskretny);

liczba_bitow = 4;
liczba_poziomow = 2^liczba_bitow;
krok_kwantyzacji = 2*amplituda / liczba_poziomow;

indeksy = round((sygnal_dyskretny + amplituda)/krok_kwantyzacji - 0.5);
indeksy = max(0, min(liczba_poziomow-1, indeksy));
sygnal_skwantowany = indeksy * krok_kwantyzacji - amplituda + krok_kwantyzacji/2;

sygnal_rek_calkowity = zeros(size(czas_ciagly));
sygnal_rek_bez_kwantyzacji = zeros(size(czas_ciagly));

for i = 1:length(czas_dyskretny)
    kernel_sinc = sinc((czas_ciagly - czas_dyskretny(i)) / okres_probkowania);
    
    sygnal_rek_calkowity = sygnal_rek_calkowity + sygnal_skwantowany(i) * kernel_sinc;
    
    sygnal_rek_bez_kwantyzacji = sygnal_rek_bez_kwantyzacji + sygnal_dyskretny(i) * kernel_sinc;
end

SNR_po_probkowaniu = 10*log10(mean(sygnal_ciagly.^2) / mean((sygnal_ciagly - sygnal_rek_bez_kwantyzacji).^2));
SNR_po_kwantyzacji = 10*log10(mean(sygnal_dyskretny.^2) / mean((sygnal_dyskretny - sygnal_skwantowany).^2));
SNR_calkowity = 10*log10(mean(sygnal_ciagly.^2) / mean((sygnal_ciagly - sygnal_rek_calkowity).^2));

fprintf('SNR przed probkowaniem: inf dB\n');
fprintf('SNR po probkowaniu: %.2f dB\n', SNR_po_probkowaniu);
fprintf('SNR po kwantyzacji: %.2f dB\n', SNR_po_kwantyzacji);
fprintf('SNR calkowity: %.2f dB\n', SNR_calkowity);

kolor_oryg = [0 0.4470 0.7410]; kolor_przetw = [0.8500 0.3250 0.0980];
fig = figure('Position', [100, 100, 800, 800], 'Color', 'w');
ustawienia = {'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.7 0.7 0.7]};

% Wykres 1
subplot(3,1,1); 
plot(czas_ciagly, sygnal_ciagly, 'Color', kolor_oryg, 'LineWidth', 1.5);
set(gca, ustawienia{:}); grid on; title('sygnal ciagly', 'Color', 'k');
xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]);

% Wykres 2
subplot(3,1,2);
stem(czas_dyskretny, sygnal_dyskretny, 'Color', kolor_oryg, 'Marker', 'o', 'LineWidth', 1); hold on;
stem(czas_dyskretny, sygnal_skwantowany, 'Color', kolor_przetw, 'Marker', '*', 'LineWidth', 1); hold off;
set(gca, ustawienia{:}); grid on; title('probki przed i po kwantyzacji (4-bit)', 'Color', 'k');
xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]);
legend('oryginalne', 'skwantyzowane', 'Location', 'northeast');

% Wykres 3
subplot(3,1,3);
plot(czas_ciagly, sygnal_ciagly, 'Color', kolor_oryg, 'LineWidth', 1.5); hold on;
plot(czas_ciagly, sygnal_rek_calkowity, '--', 'Color', kolor_przetw, 'LineWidth', 1.5); hold off;
set(gca, ustawienia{:}); grid on; title(sprintf('rekonstrukcja sygnalu | SNR = %.2f dB', SNR_calkowity), 'Color', 'k');
xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]);
legend('oryginal', 'rekonstrukcja', 'Location', 'northeast');