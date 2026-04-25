czestotliwosc_sygnalu = 5;          
amplituda = 1;                      
czas_ciagly = 0:0.0001:1;           
czestotliwosc_probkowania = 50;     
okres_probkowania = 1/czestotliwosc_probkowania;  
czas_dyskretny = 0:okres_probkowania:1;   

% WARIANT A: Sinusoidalny
sygnal_ciagly = amplituda * sin(2*pi*czestotliwosc_sygnalu*czas_ciagly); 
sygnal_dyskretny = amplituda * sin(2*pi*czestotliwosc_sygnalu*czas_dyskretny); 

% WARIANT B: Prostokątny
%sygnal_ciagly = amplituda * square(2*pi*czestotliwosc_sygnalu*czas_ciagly); 
%sygnal_dyskretny = amplituda * square(2*pi*czestotliwosc_sygnalu*czas_dyskretny);

liczba_poziomow = 2^4;   
sygnal_skwantowany = round(((sygnal_dyskretny + amplituda)/(2*amplituda)) * (liczba_poziomow-1)) / (liczba_poziomow-1);
sygnal_skwantowany = (sygnal_skwantowany * 2*amplituda) - amplituda;

sygnal_rek = zeros(size(czas_ciagly));
for i = 1:length(czas_dyskretny)
    sygnal_rek = sygnal_rek + sygnal_skwantowany(i) * sinc((czas_ciagly - czas_dyskretny(i)) / okres_probkowania);
end

snr_db = 10 * log10(var(sygnal_ciagly) / var(sygnal_ciagly - sygnal_rek));

kolor_oryg = [0 0.4470 0.7410]; kolor_przetw = [0.8500 0.3250 0.0980];
fig = figure('Position', [100, 100, 800, 800], 'Color', 'w');
ustawienia = {'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.7 0.7 0.7]};

subplot(3,1,1);
plot(czas_ciagly, sygnal_ciagly, 'Color', kolor_oryg, 'LineWidth', 1.5);
set(gca, ustawienia{:}); grid on; title('sygnal ciagly', 'Color', 'k');
xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]);

subplot(3,1,2);
stem(czas_dyskretny, sygnal_dyskretny, 'Color', kolor_oryg, 'Marker', 'o', 'LineWidth', 1); hold on;
stem(czas_dyskretny, sygnal_skwantowany, 'Color', kolor_przetw, 'Marker', '*', 'LineWidth', 1); hold off;
set(gca, ustawienia{:}); grid on; title('probki przed i po kwantyzacji (4-bit)', 'Color', 'k');
xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]);
legend('oryginalne', 'skwantyzowane', 'Location', 'northeast');

subplot(3,1,3);
plot(czas_ciagly, sygnal_ciagly, 'Color', kolor_oryg, 'LineWidth', 1.5); hold on;
plot(czas_ciagly, sygnal_rek, '--', 'Color', kolor_przetw, 'LineWidth', 1.5); hold off;
set(gca, ustawienia{:}); grid on; title(sprintf('rekonstrukcja sygnalu | SNR = %.2f dB', snr_db), 'Color', 'k');
xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]);
legend('oryginal', 'rekonstrukcja', 'Location', 'northeast');