kolor_czas = [0, 0.4470, 0.7410];
kolor_zmodulowany = [0.4660, 0.6740, 0.1880];
kolor_widmo = [0.8500, 0.3250, 0.0980];

czestotliwosc_ciagla = 10000;
czas_ciagly = 0:(1/czestotliwosc_ciagla):0.2;

czestotliwosc_nosna_1 = 500;
amplituda_nosna_1 = 1;

czestotliwosc_informacyjna_1 = 20;
amplituda_informacyjna_1 = 0.5;

sygnal_informacyjny_1 = amplituda_informacyjna_1 * sin(2*pi*czestotliwosc_informacyjna_1*czas_ciagly);
sygnal_zmodulowany_1 = (amplituda_nosna_1 + sygnal_informacyjny_1) .* sin(2*pi*czestotliwosc_nosna_1*czas_ciagly);

[os_czestotliwosci_informacyjna_1, widmo_informacyjne_1] = oblicz_transformate_fouriera(sygnal_informacyjny_1, czestotliwosc_ciagla);
[os_czestotliwosci_zmodulowana_1, widmo_zmodulowane_1] = oblicz_transformate_fouriera(sygnal_zmodulowany_1, czestotliwosc_ciagla);

figure('Name', 'ETAP 1: Modulacja amplitudowa pojedynczego sinusa', 'Position', [50, 50, 1000, 700]);
subplot(2,2,1); plot(czas_ciagly, sygnal_informacyjny_1, 'Color', kolor_czas, 'LineWidth', 1.5);
title('Sygnał informacyjny w czasie'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]); grid on;
subplot(2,2,2); stem(os_czestotliwosci_informacyjna_1, widmo_informacyjne_1, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo sygnału informacyjnego'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([0 50]); grid on;
subplot(2,2,3); plot(czas_ciagly, sygnal_zmodulowany_1, 'Color', kolor_zmodulowany, 'LineWidth', 1.5);
title('Sygnał zmodulowany amplitudowo w czasie'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-2 2]); grid on;
subplot(2,2,4); stem(os_czestotliwosci_zmodulowana_1, widmo_zmodulowane_1, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo sygnału po modulacji amplitudowej'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([400 600]); grid on;

czestotliwosci_skladowe = [15, 35, 60];
amplitudy_skladowe = [0.3, 0.2, 0.1];

sygnal_informacyjny_2 = zeros(size(czas_ciagly));
for k = 1:length(czestotliwosci_skladowe)
    sygnal_informacyjny_2 = sygnal_informacyjny_2 + amplitudy_skladowe(k) * sin(2*pi*czestotliwosci_skladowe(k)*czas_ciagly);
end

sygnal_zmodulowany_2 = (amplituda_nosna_1 + sygnal_informacyjny_2) .* sin(2*pi*czestotliwosc_nosna_1*czas_ciagly);

[os_czestotliwosci_informacyjna_2, widmo_informacyjne_2] = oblicz_transformate_fouriera(sygnal_informacyjny_2, czestotliwosc_ciagla);
[os_czestotliwosci_zmodulowana_2, widmo_zmodulowane_2] = oblicz_transformate_fouriera(sygnal_zmodulowany_2, czestotliwosc_ciagla);

figure('Name', 'ETAP 2: Modulacja amplitudowa sygnału złożonego', 'Position', [100, 100, 1000, 700]);
subplot(2,2,1); plot(czas_ciagly, sygnal_informacyjny_2, 'Color', kolor_czas, 'LineWidth', 1.5);
title('Sygnał złożony w czasie'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]); grid on;
subplot(2,2,2); stem(os_czestotliwosci_informacyjna_2, widmo_informacyjne_2, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo sygnału złożonego'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([0 100]); grid on;
subplot(2,2,3); plot(czas_ciagly, sygnal_zmodulowany_2, 'Color', kolor_zmodulowany, 'LineWidth', 1.5);
title('Sygnał złożony zmodulowany amplitudowo w czasie'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-2 2]); grid on;
subplot(2,2,4); stem(os_czestotliwosci_zmodulowana_2, widmo_zmodulowane_2, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo złożonego sygnału po modulacji amplitudowej'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([400 600]); grid on;

czestotliwosc_dyskretna = 2000;
czas_dyskretny = 0:(1/czestotliwosc_dyskretna):0.1;

sygnal_informacyjny_3 = zeros(size(czas_dyskretny));
for k = 1:length(czestotliwosci_skladowe)
    sygnal_informacyjny_3 = sygnal_informacyjny_3 + amplitudy_skladowe(k) * sin(2*pi*czestotliwosci_skladowe(k)*czas_dyskretny);
end

sygnal_zmodulowany_3 = (amplituda_nosna_1 + sygnal_informacyjny_3) .* sin(2*pi*czestotliwosc_nosna_1*czas_dyskretny);

[os_czestotliwosci_informacyjna_3, widmo_informacyjne_3] = oblicz_transformate_fouriera(sygnal_informacyjny_3, czestotliwosc_dyskretna);
[os_czestotliwosci_zmodulowana_3, widmo_zmodulowane_3] = oblicz_transformate_fouriera(sygnal_zmodulowany_3, czestotliwosc_dyskretna);

figure('Name', 'ETAP 3: Modulacja amplitudowa sygnału dyskretnego', 'Position', [150, 150, 1000, 700]);
subplot(2,2,1); stem(czas_dyskretny, sygnal_informacyjny_3, 'Color', kolor_czas, 'Marker', 'o', 'LineWidth', 1);
title('Dyskretny sygnał informacyjny'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-1.2 1.2]); grid on;
subplot(2,2,2); stem(os_czestotliwosci_informacyjna_3, widmo_informacyjne_3, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo sygnału dyskretnego'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([0 100]); grid on;
subplot(2,2,3); stem(czas_dyskretny, sygnal_zmodulowany_3, 'Color', kolor_zmodulowany, 'Marker', '*', 'LineWidth', 1);
title('Dyskretny sygnał zmodulowany amplitudowo'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-2 2]); grid on;
subplot(2,2,4); stem(os_czestotliwosci_zmodulowana_3, widmo_zmodulowane_3, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo dyskretnego sygnału po modulacji amplitudowej'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([300 700]); grid on;

load handel.mat;
probki_audio = y(1:1000)';
czestotliwosc_probkowania_audio = Fs;
czas_audio = (0:length(probki_audio)-1) / czestotliwosc_probkowania_audio;

sygnal_informacyjny_4 = 0.8 * (probki_audio / max(abs(probki_audio)));
czestotliwosc_nosna_audio = 2000;
amplituda_nosna_audio = 1;

sygnal_zmodulowany_4 = (amplituda_nosna_audio + sygnal_informacyjny_4) .* sin(2*pi*czestotliwosc_nosna_audio*czas_audio);

[os_czestotliwosci_informacyjna_4, widmo_informacyjne_4] = oblicz_transformate_fouriera(sygnal_informacyjny_4, czestotliwosc_probkowania_audio);
[os_czestotliwosci_zmodulowana_4, widmo_zmodulowane_4] = oblicz_transformate_fouriera(sygnal_zmodulowany_4, czestotliwosc_probkowania_audio);

figure('Name', 'ETAP 4: Modulacja amplitudowa dźwięku', 'Position', [200, 200, 1000, 700]);
subplot(2,2,1); plot(czas_audio, sygnal_informacyjny_4, 'Color', kolor_czas, 'LineWidth', 1);
title('Krótki fragment nagrania (informacja)'); xlabel('czas [s]'); ylabel('amplituda'); grid on;
subplot(2,2,2); stem(os_czestotliwosci_informacyjna_4, widmo_informacyjne_4, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo nagrania'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([0 1500]); grid on;
subplot(2,2,3); plot(czas_audio, sygnal_zmodulowany_4, 'Color', kolor_zmodulowany, 'LineWidth', 1);
title('Nagranie zmodulowane amplitudowo'); xlabel('czas [s]'); ylabel('amplituda'); ylim([-2 2]); grid on;
subplot(2,2,4); stem(os_czestotliwosci_zmodulowana_4, widmo_zmodulowane_4, 'Color', kolor_widmo, 'Marker', 'none', 'LineWidth', 1.5);
title('Widmo nagrania po modulacji amplitudowej'); xlabel('częstotliwość [Hz]'); ylabel('amplituda'); xlim([500 3500]); grid on;

function [os_czestotliwosci, widmo_amplitudowe] = oblicz_transformate_fouriera(sygnal, czestotliwosc_probkowania)
    dlugosc_sygnalu = length(sygnal);
    transformata = fft(sygnal);                  
    widmo_dwustronne = abs(transformata / dlugosc_sygnalu);                 
    widmo_jednostronne = widmo_dwustronne(1:floor(dlugosc_sygnalu/2)+1); 
    widmo_jednostronne(2:end-1) = 2 * widmo_jednostronne(2:end-1); 
    
    os_czestotliwosci = czestotliwosc_probkowania * (0:floor(dlugosc_sygnalu/2)) / dlugosc_sygnalu; 
    
    os_czestotliwosci = os_czestotliwosci(:)';
    widmo_amplitudowe = widmo_jednostronne(:)';
end