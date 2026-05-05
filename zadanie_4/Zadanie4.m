% Punkt 1
liczba_sinusow = 4; 
czestotliwosc_probkowania = 200; 
okres_probkowania = 1/czestotliwosc_probkowania;
czas_ciagly = 0:0.001:1; 
czas_dyskretny = 0:okres_probkowania:1;
f = [5, 12, 18, 25, 33, 41, 55, 65]; 
A = [1, 0.8, 0.6, 0.4, 0.5, 0.3, 0.2, 0.1]; 
P = [0, pi/4, pi/2, pi, 0, pi/3, pi/6, pi/8]; 

sygnal_ciagly = zeros(size(czas_ciagly));
sygnal_dyskretny = zeros(size(czas_dyskretny));

for k = 1:liczba_sinusow
    sygnal_ciagly = sygnal_ciagly + A(k) * sin(2*pi*f(k)*czas_ciagly + P(k));
    sygnal_dyskretny = sygnal_dyskretny + A(k) * sin(2*pi*f(k)*czas_dyskretny + P(k));
end

% Punkt 2
liczba_bitow = 4;
liczba_poziomow = 2^liczba_bitow;

amplituda = sum(A(1:liczba_sinusow)); 
krok_kwantyzacji = 2*amplituda / liczba_poziomow;

indeksy = round((sygnal_dyskretny + amplituda)/krok_kwantyzacji - 0.5);
indeksy = max(0, min(liczba_poziomow-1, indeksy));
sygnal_skwantowany = indeksy * krok_kwantyzacji - amplituda + krok_kwantyzacji/2;

widmo_przed = abs(fft(sygnal_ciagly));
widmo_po = abs(fft(sygnal_skwantowany));

czestotliwosc_symulacji = 1 / (czas_ciagly(2) - czas_ciagly(1));

liczba_probek_ciaglych = length(sygnal_ciagly);
os_czestotliwosci_ciagla = (0 : liczba_probek_ciaglych-1) * (czestotliwosc_symulacji / liczba_probek_ciaglych); 

liczba_probek_dyskretnych = length(sygnal_skwantowany);
os_czestotliwosci_dyskretna = (0 : liczba_probek_dyskretnych-1) * (czestotliwosc_probkowania / liczba_probek_dyskretnych);

figure('Name', 'Nowe Zadanie');
subplot(2,1,1);
plot(czas_ciagly, sygnal_ciagly, 'b'); hold on;
stem(czas_dyskretny, sygnal_skwantowany, 'r');
title('Sygnaly w dziedzinie czasu (Suma Sinusów)');
legend('Przed A/C', 'Po A/C');
xlabel('Czas [s]'); 
ylabel('Amplituda');

subplot(2,1,2);
plot(os_czestotliwosci_ciagla, widmo_przed, 'b'); hold on;
stem(os_czestotliwosci_dyskretna, widmo_po, 'r');
title('Transformacja Fouriera (FFT) - Suma Sinusów');
legend('Widmo przed A/C', 'Widmo po A/C');
xlabel('Czestotliwosc [Hz]'); 
ylabel('Amplituda');
xlim([0 100]); 

% Punkt 3
czestotliwosc_sygnalu_stara = 5;
amplituda_stara = 1;
czas_ciagly_stary = 0:0.0001:1;
czestotliwosc_probkowania_stara = 50;
okres_probkowania_stary = 1/czestotliwosc_probkowania_stara;
czas_dyskretny_stary = 0:okres_probkowania_stary:1;

sygnal_ciagly_stary = amplituda_stara * sin(2*pi*czestotliwosc_sygnalu_stara*czas_ciagly_stary); 
sygnal_dyskretny_stary = amplituda_stara * sin(2*pi*czestotliwosc_sygnalu_stara*czas_dyskretny_stary);

liczba_bitow_stara = 4;
liczba_poziomow_stara = 2^liczba_bitow_stara;
krok_kwantyzacji_stary = 2*amplituda_stara / liczba_poziomow_stara;

indeksy_stare = round((sygnal_dyskretny_stary + amplituda_stara)/krok_kwantyzacji_stary - 0.5);
indeksy_stare = max(0, min(liczba_poziomow_stara-1, indeksy_stare));
sygnal_skwantowany_stary = indeksy_stare * krok_kwantyzacji_stary - amplituda_stara + krok_kwantyzacji_stary/2;

widmo_przed_stare = abs(fft(sygnal_ciagly_stary));
widmo_po_stare = abs(fft(sygnal_skwantowany_stary));

czestotliwosc_symulacji_stara = 1 / (czas_ciagly_stary(2) - czas_ciagly_stary(1)); 

liczba_probek_ciaglych_starych = length(sygnal_ciagly_stary);
os_czestotliwosci_ciagla_stara = (0 : liczba_probek_ciaglych_starych-1) * (czestotliwosc_symulacji_stara / liczba_probek_ciaglych_starych); 

liczba_probek_dyskretnych_starych = length(sygnal_skwantowany_stary);
os_czestotliwosci_dyskretna_stara = (0 : liczba_probek_dyskretnych_starych-1) * (czestotliwosc_probkowania_stara / liczba_probek_dyskretnych_starych);

figure('Name', 'Poprzednie Zadanie');
subplot(2,1,1);
plot(czas_ciagly_stary, sygnal_ciagly_stary, 'b'); hold on;
stem(czas_dyskretny_stary, sygnal_skwantowany_stary, 'r');
title('POPRZEDNIE ZADANIE: Dziedzina czasu (Pojedynczy sinus)');
legend('Przed A/C', 'Po A/C');
xlabel('Czas [s]'); 
ylabel('Amplituda');

subplot(2,1,2);
plot(os_czestotliwosci_ciagla_stara, widmo_przed_stare, 'b'); hold on;
stem(os_czestotliwosci_dyskretna_stara, widmo_po_stare, 'r');
title('POPRZEDNIE ZADANIE: Transformacja Fouriera (FFT)');
legend('Widmo przed A/C', 'Widmo po A/C');
xlabel('Czestotliwosc [Hz]'); 
ylabel('Amplituda');
xlim([0 50]);