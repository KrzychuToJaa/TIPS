% =========================================================================
% ETAP 0: Przygotowanie alfabetu (cyfry 0-9 oraz małe litery a-z)
% =========================================================================
alfabet = ['0':'9', 'a':'z'];
rozmiar_alfabetu = length(alfabet);
symbole_alfabetu = num2cell(alfabet);

% =========================================================================
% ETAP 1: Kodowanie losowego ciągu znaków
% =========================================================================
dlugosc_ciagu = 1000;

% 1. Generowanie losowego ciągu znaków z naszego alfabetu
losowe_indeksy = randi([1, rozmiar_alfabetu], 1, dlugosc_ciagu);
ciag_losowy = alfabet(losowe_indeksy);

% 2. Obliczanie prawdopodobieństwa wystąpienia każdego znaku
wystapienia_losowe = zeros(1, rozmiar_alfabetu);
for i = 1:rozmiar_alfabetu
    wystapienia_losowe(i) = sum(ciag_losowy == alfabet(i));
end
prawdopodobienstwa_losowe = wystapienia_losowe / dlugosc_ciagu;

% 3. Usunięcie znaków, które nie wystąpiły ani razu (prawdopodobieństwo = 0)
czy_niezerowe_losowe = prawdopodobienstwa_losowe > 0;
uzyte_symbole_losowe = symbole_alfabetu(czy_niezerowe_losowe);
uzyte_prawdobienstwa_losowe = prawdopodobienstwa_losowe(czy_niezerowe_losowe);

% 4. Tworzenie słownika Huffmana
[slownik_losowy, srednia_dlugosc_losowa] = huffmandict(uzyte_symbole_losowe, uzyte_prawdobienstwa_losowe);

% 5. Kodowanie i dekodowanie
ciag_losowy_do_kodowania = num2cell(ciag_losowy);
zakodowane_bity_losowe = huffmanenco(ciag_losowy_do_kodowania, slownik_losowy);
odkodowane_komorki_losowe = huffmandeco(zakodowane_bity_losowe, slownik_losowy);
odkodowany_ciag_losowy = cell2mat(odkodowane_komorki_losowe);

% 6. Sprawdzenie poprawności
czy_identyczne_losowe = isequal(ciag_losowy, odkodowany_ciag_losowy);
disp('--- CIĄG LOSOWY ---');
disp(['Czy odkodowany ciąg jest w 100% zgodny z oryginałem? ', num2str(czy_identyczne_losowe)]);
disp(['Średnia długość pojedynczego kodu: ', num2str(srednia_dlugosc_losowa), ' bitów na znak']);


% =========================================================================
% ETAP 2: Kodowanie naturalnego tekstu (język polski)
% =========================================================================

% 1. Tworzenie długiego ciągu tekstowego (powielamy próbkę, aby przekroczyć 1000 znaków)
probka_tekstu = 'litwoojczyznomojatyjestesjakzdrowieilecietrzebacenictentylkosiedowiektociestracildzispieknosctwawcalejozdobiewidzeiopisujeboteskniepotobie';
ciag_tekstowy = repmat(probka_tekstu, 1, 10); 
dlugosc_tekstu = length(ciag_tekstowy);

% 2. Obliczanie prawdopodobieństwa wystąpienia każdego znaku w tekście
wystapienia_tekst = zeros(1, rozmiar_alfabetu);
for i = 1:rozmiar_alfabetu
    wystapienia_tekst(i) = sum(ciag_tekstowy == alfabet(i));
end
prawdopodobienstwa_tekst = wystapienia_tekst / dlugosc_tekstu;

% 3. Usunięcie znaków, które nie wystąpiły w tekście (np. 'q', 'x', '7')
czy_niezerowe_tekst = prawdopodobienstwa_tekst > 0;
uzyte_symbole_tekst = symbole_alfabetu(czy_niezerowe_tekst);
uzyte_prawdobienstwa_tekst = prawdopodobienstwa_tekst(czy_niezerowe_tekst);

% 4. Tworzenie słownika Huffmana
[slownik_tekstowy, srednia_dlugosc_tekstowa] = huffmandict(uzyte_symbole_tekst, uzyte_prawdobienstwa_tekst);

% 5. Kodowanie i dekodowanie
ciag_tekstowy_do_kodowania = num2cell(ciag_tekstowy);
zakodowane_bity_tekst = huffmanenco(ciag_tekstowy_do_kodowania, slownik_tekstowy);
odkodowane_komorki_tekst = huffmandeco(zakodowane_bity_tekst, slownik_tekstowy);
odkodowany_ciag_tekstowy = cell2mat(odkodowane_komorki_tekst);

% 6. Sprawdzenie poprawności
czy_identyczne_tekst = isequal(ciag_tekstowy, odkodowany_ciag_tekstowy);
disp(' ');
disp('--- TEKST NATURALNY ---');
disp(['Czy odkodowany tekst jest w 100% zgodny z oryginałem? ', num2str(czy_identyczne_tekst)]);
disp(['Średnia długość pojedynczego kodu: ', num2str(srednia_dlugosc_tekstowa), ' bitów na znak']);