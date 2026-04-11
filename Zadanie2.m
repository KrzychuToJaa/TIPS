% ETAP 1: 
alfabet = ['0':'9', 'a':'z'];
rozmiar_alfabetu = length(alfabet);
symbole_alfabetu = num2cell(alfabet);

% ETAP 2: 
dlugosc_ciagu = 1000;
losowe_indeksy = randi([1, rozmiar_alfabetu], 1, dlugosc_ciagu);
ciag_losowy = alfabet(losowe_indeksy);

wystapienia_losowe = zeros(1, rozmiar_alfabetu);
for i = 1:rozmiar_alfabetu
    wystapienia_losowe(i) = sum(ciag_losowy == alfabet(i));
end
prawdopodobienstwa_losowe = wystapienia_losowe / dlugosc_ciagu;

czy_niezerowe_losowe = prawdopodobienstwa_losowe > 0;
uzyte_symbole_losowe = symbole_alfabetu(czy_niezerowe_losowe);
uzyte_prawdopodobienstwa_losowe = prawdopodobienstwa_losowe(czy_niezerowe_losowe);

[slownik_losowy, srednia_dlugosc_losowa] = huffmandict(uzyte_symbole_losowe, uzyte_prawdopodobienstwa_losowe);

ciag_losowy_do_kodowania = num2cell(ciag_losowy);
zakodowane_bity_losowe = huffmanenco(ciag_losowy_do_kodowania, slownik_losowy);
odkodowane_komorki_losowe = huffmandeco(zakodowane_bity_losowe, slownik_losowy);
odkodowany_ciag_losowy = cell2mat(odkodowane_komorki_losowe);

czy_identyczne_losowe = isequal(ciag_losowy, odkodowany_ciag_losowy);
disp('Interpretacja ciągu losowego');
if  (czy_identyczne_losowe)
    disp('Ciąg znaków zgodny z oryginałem');
end
disp(['Średnia długość pojedynczego kodu: ', num2str(srednia_dlugosc_losowa), ' bitów na znak']);

% ETAP 3:
probka_tekstu = 'ktozzbadalglebiematecznikastrasznejadraogromnemiedzyblotamiitrawyniedostepnecomowicokniekniejiktodowewnatrzniezajrzyprawieajakibylwidokwszystkopotopioneiwodaiblotemidymemmglyktorastaleunosisienadtemioczodolamiidlategozadenclowiektamniepostanionogiwonnychchmielowitrawigestwytamogromneiwielkiejakdrzewadziwneiosobliweroslinyrosnatamwszystkobezladniepomieszaneiwzajemniesieducisplatajacpotwornewezlykorzeniigaleziatobowiemjestpanstwolwowiniedzwiedzitamtoczysiezycieodwiekowprzeznikogonietknieteitylkozwierzetaznajatesciezkiiktorymiuciekajaprzedpogoniomysliwcacotozastrasznemiejscegdziessrodkuwysepekdrzewastojajakolbrzymyizadnaaxatychpniowpowalicniezdolaatamwsrodkutegochaosuijestmateczniksercepuszczygdziezwierzetamajaswojspokojischronienienikttamniewejdzienikttegoniezbadatylkoechomysliwskiegoroguczasemtamdoleciizbudzipotworyspiacevgaszczachitaktojestwmatecznikunaostatnimkrancuswiataidalejjuzniamanicproczmglyiblotaktorychnienawidzaludzieatylkozwierzetatamzyjaiznajateciemneiprerazajacesciezkiktoreprowadzadoglebi';
dlugosc_tekstu = length(probka_tekstu);

wystapienia_tekst = zeros(1, rozmiar_alfabetu);
for i = 1:rozmiar_alfabetu
    wystapienia_tekst(i) = sum(probka_tekstu == alfabet(i));
end
prawdopodobienstwa_tekst = wystapienia_tekst / dlugosc_tekstu;

czy_niezerowe_tekst = prawdopodobienstwa_tekst > 0;
uzyte_symbole_tekst = symbole_alfabetu(czy_niezerowe_tekst);
uzyte_prawdopodobienstwa_tekst = prawdopodobienstwa_tekst(czy_niezerowe_tekst);

[slownik_tekstowy, srednia_dlugosc_tekstowa] = huffmandict(uzyte_symbole_tekst, uzyte_prawdopodobienstwa_tekst);

ciag_tekstowy_do_kodowania = num2cell(probka_tekstu);
zakodowane_bity_tekst = huffmanenco(ciag_tekstowy_do_kodowania, slownik_tekstowy);
odkodowane_komorki_tekst = huffmandeco(zakodowane_bity_tekst, slownik_tekstowy);
odkodowany_ciag_tekstowy = cell2mat(odkodowane_komorki_tekst);

czy_identyczne_tekst = isequal(probka_tekstu, odkodowany_ciag_tekstowy);
disp(' ');
disp('Interpretacja tekstu');
if  (czy_identyczne_tekst)
    disp('Ciąg znaków zgodny z oryginałem');
end
disp(['Średnia długość pojedynczego kodu: ', num2str(srednia_dlugosc_tekstowa), ' bitów na znak']);