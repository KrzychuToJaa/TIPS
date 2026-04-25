%% 1. Parametry wejściowe i wygenerowanie "ciągłego" sygnału
czestotliwosc_sygnalu = 5;          % Częstotliwość sygnału w Hz
amplituda = 1;                      % Amplituda sygnału
czas_ciagly = 0:0.0001:1;           % Bardzo gęsty wektor czasu - symulacja ciągłości

% Sygnał "ciągły" (sinusoidalny)
sygnal_ciagly = amplituda * sin(2*pi*czestotliwosc_sygnalu*czas_ciagly); 

% Alternatywnie: sygnał prostokątny (odkomentuj poniższą linię, wymaga Signal Processing Toolbox)
% sygnal_ciagly = amplituda * square(2*pi*czestotliwosc_sygnalu*czas_ciagly); 

%% 2. Próbkowanie (Postać ciągła -> Dyskretna)
czestotliwosc_probkowania = 50;     % Częstotliwość próbkowania w Hz
okres_probkowania = 1/czestotliwosc_probkowania;  % Okres próbkowania
czas_dyskretny = 0:okres_probkowania:1;           % Wektor czasu dla sygnału dyskretnego

% Spróbkowany sygnał (dokładne wartości)
sygnal_dyskretny = amplituda * sin(2*pi*czestotliwosc_sygnalu*czas_dyskretny); 

%% 3. Kwantyzacja (Ograniczenie poziomów amplitudy)
liczba_bitow = 4;                   % Rozdzielczość w bitach
liczba_poziomow = 2^liczba_bitow;   % Liczba poziomów kwantyzacji

% Prosta metoda kwantyzacji jednorodnej:
sygnal_znormalizowany = (sygnal_dyskretny + amplituda) / (2*amplituda); % Normalizacja do przedziału [0, 1]
sygnal_skwantowany = round(sygnal_znormalizowany * (liczba_poziomow-1)) / (liczba_poziomow-1); % Kwantyzacja
sygnal_skwantowany = (sygnal_skwantowany * 2*amplituda) - amplituda; % Powrót do pierwotnej amplitudy [-A, A]

%% 4. Odtworzenie sygnału (Postać dyskretna -> Ciągła)
% Używamy funkcji 'stairs' w sekcji rysowania wykresów do wizualizacji 
% metody ZOH (Zero-Order Hold), co daje charakterystyczne "schodki".

%% 5. Obliczenie SNR (Signal-to-Noise Ratio)
% Szum kwantyzacji to różnica między próbkami dokładnymi a skwantowanymi
szum_kwantyzacji = sygnal_dyskretny - sygnal_skwantowany; 

% Moc sygnału spróbkowanego i moc szumu
moc_sygnalu = var(sygnal_dyskretny); 
moc_szumu = var(szum_kwantyzacji);

% Obliczenie SNR w decybelach (dB)
if moc_szumu == 0
    snr_db = Inf; % Jeśli nie ma szumu (idealne trafienia z poziomami)
else
    snr_db = 10 * log10(moc_sygnalu / moc_szumu);
end
fprintf('Wyliczony współczynnik SNR dla %d bitów wynosi: %.2f dB\n', liczba_bitow, snr_db);

%% 6. Wizualizacja
figure;

% Wykres 1: Sygnał ciągły
subplot(3,1,1);
plot(czas_ciagly, sygnal_ciagly, 'b', 'LineWidth', 1.5);
title('Sygnał "Ciągły"'); 
xlabel('Czas [s]'); 
ylabel('Amplituda'); 
grid on;

% Wykres 2: Sygnał spróbkowany
subplot(3,1,2);
stem(czas_dyskretny, sygnal_dyskretny, 'r', 'filled');
title(sprintf('Sygnał Spróbkowany (fs = %d Hz)', czestotliwosc_probkowania)); 
xlabel('Czas [s]'); 
ylabel('Amplituda'); 
grid on;

% Wykres 3: Sygnał skwantowany i zrekonstruowany (ZOH)
subplot(3,1,3);
stairs(czas_dyskretny, sygnal_skwantowany, 'k', 'LineWidth', 1.5); hold on;
stem(czas_dyskretny, sygnal_skwantowany, 'k'); hold off;
title(sprintf('Sygnał Skwantowany (Bity = %d) -> Zrekonstruowany (ZOH)', liczba_bitow));
xlabel('Czas [s]'); 
ylabel('Amplituda'); 
grid on;