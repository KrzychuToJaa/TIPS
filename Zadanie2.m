% ETAP 1: Definicja alfabetu podstawowego (0-9, a-z)
alfabet_bazowy = ['0':'9', 'a':'z'];
rozmiar_bazowy = length(alfabet_bazowy);
symbole_bazowe = num2cell(alfabet_bazowy);
bity_przed_bazowy = ceil(log2(rozmiar_bazowy));

% ETAP 2: Generowanie i kodowanie ciągu losowego
dlugosc_ciagu = 1000;
losowe_indeksy = randi([1, rozmiar_bazowy], 1, dlugosc_ciagu);
ciag_losowy = alfabet_bazowy(losowe_indeksy);

wystapienia_losowe = zeros(1, rozmiar_bazowy);
for i = 1:rozmiar_bazowy
    wystapienia_losowe(i) = sum(ciag_losowy == alfabet_bazowy(i));
end

prob_losowe = wystapienia_losowe / dlugosc_ciagu;
maska_losowe = prob_losowe > 0;
uzyte_symbole_losowe = symbole_bazowe(maska_losowe);
[slownik_losowy, avg_len_losowy] = huffmandict(uzyte_symbole_losowe, prob_losowe(maska_losowe));

zakodowane_losowe = huffmanenco(num2cell(ciag_losowy), slownik_losowy);
odkodowane_losowe = cell2mat(huffmandeco(zakodowane_losowe, slownik_losowy));
if isequal(ciag_losowy, odkodowane_losowe)
    disp('Status ciągu losowego: Zdekodowany zgodnie z oryginałem.');
end
disp(['Średnia długość przed: ', num2str(bity_przed_bazowy), ' bitów']);
disp(['Średnia długość po: ', num2str(avg_len_losowy), ' bitów']);
disp(' ');

% ETAP 3: Kodowanie tekstu naturalnego z pliku (rozszerzony alfabet)
pl_znaki = 'ąćęłńóśźżĄĆĘŁŃÓŚŹŻ';
interpunkcja = '.,:;-?! ';
alfabet_rozszerzony = ['0':'9', 'a':'z', 'A':'Z', pl_znaki, interpunkcja];
rozmiar_rozszerzony = length(alfabet_rozszerzony);
symbole_rozszerzone = num2cell(alfabet_rozszerzony);
bity_przed_rozszerzony = ceil(log2(rozmiar_rozszerzony));

nazwa_pliku = 'tekst.txt';
surowy_tekst = fileread(nazwa_pliku);
probka_tekstu = surowy_tekst(ismember(surowy_tekst, alfabet_rozszerzony));
dlugosc_tekstu = length(probka_tekstu);

wystapienia_tekst = zeros(1, rozmiar_rozszerzony);
for i = 1:rozmiar_rozszerzony
    wystapienia_tekst(i) = sum(probka_tekstu == alfabet_rozszerzony(i));
end

prob_tekst = wystapienia_tekst / dlugosc_tekstu;
maska_tekst = prob_tekst > 0;
uzyte_symbole_tekst = symbole_rozszerzone(maska_tekst);
[slownik_tekstowy, avg_len_tekstowy] = huffmandict(uzyte_symbole_tekst, prob_tekst(maska_tekst));

zakodowane_tekst = huffmanenco(num2cell(probka_tekstu), slownik_tekstowy);
odkodowane_tekst = cell2mat(huffmandeco(zakodowane_tekst, slownik_tekstowy));
if isequal(probka_tekstu, odkodowane_tekst)
    disp('Status tekstu naturalnego: Zdekodowany zgodnie z oryginałem.');
end

% ETAP 4: Wyświetlanie wyników i słowników dla tekstu
disp('SŁOWNIK PRZED KODOWANIEM:');
for i = 1:length(uzyte_symbole_tekst)
    s = uzyte_symbole_tekst{i};
    idx = find(alfabet_rozszerzony == s) - 1;
    fprintf('Znak: ''%s'' -> Kod stały: %s\n', s, dec2bin(idx, bity_przed_rozszerzony));
end

disp(' ');
disp('SŁOWNIK PO KODOWANIU:');
for i = 1:size(slownik_tekstowy, 1)
    fprintf('Znak: ''%s'' -> Kod zmienny: %s\n', slownik_tekstowy{i,1}, num2str(slownik_tekstowy{i,2}, '%d'));
end

oszczednosc = (1 - (avg_len_tekstowy / bity_przed_rozszerzony)) * 100;
disp(' ');
disp('PODSUMOWANIE KOMPRESJI TEKSTU:');
disp(['Średnia długość przed: ', num2str(bity_przed_rozszerzony), ' bitów na znak']);
disp(['Średnia długość po: ', num2str(avg_len_tekstowy), ' bitów na znak']);
disp(['Oszczędność: ', num2str(oszczednosc, '%.2f'), '%']);