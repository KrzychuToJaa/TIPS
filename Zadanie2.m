% =========================================================================
% ETAP 0: Inicjalizacja alfabetu (0-9, a-z)
% =========================================================================
alphabet = ['0':'9', 'a':'z'];
num_symbols = length(alphabet);
symbols = num2cell(alphabet);

% =========================================================================
% ETAP 1: Kodowanie losowego ciągu znaków (>= 1000)
% =========================================================================
N = 1000;
% Generujemy całkowicie losowe indeksy (rozkład jednostajny)
rand_idx = randi([1, num_symbols], 1, N);
random_seq = alphabet(rand_idx);

% Obliczanie rzeczywistych częstotliwości (prawdopodobieństw) w ciągu losowym
counts_rand = zeros(1, num_symbols);
for i = 1:num_symbols
    counts_rand(i) = sum(random_seq == alphabet(i));
end
prob_rand = counts_rand / N;

% Usunięcie symboli o prawdopodobieństwie 0 (wymaganie funkcji huffmandict)
valid_idx_r = prob_rand > 0;
symbols_rand_valid = symbols(valid_idx_r);
prob_rand_valid = prob_rand(valid_idx_r);

% Tworzenie słownika Huffmana i pobranie średniej długości słowa
[dict_rand, avg_len_rand] = huffmandict(symbols_rand_valid, prob_rand_valid);

% Kodowanie i dekodowanie
sig_rand_cell = num2cell(random_seq);
hcode_rand = huffmanenco(sig_rand_cell, dict_rand);
dhsig_rand_cell = huffmandeco(hcode_rand, dict_rand);
decoded_rand = cell2mat(dhsig_rand_cell);

% Sprawdzenie poprawności
is_equal_rand = isequal(random_seq, decoded_rand);
disp('--- CIĄG LOSOWY ---');
disp(['Czy odkodowany ciąg jest identyczny z oryginałem? ', num2str(is_equal_rand)]);
disp(['Średnia długość słowa kodowego: ', num2str(avg_len_rand), ' bitów/znak']);

% =========================================================================
% ETAP 2: Kodowanie tekstu naturalnego (>= 1000 znaków)
% =========================================================================
% Używamy POJEDYNCZYCH cudzysłowów, aby stworzyć wektor znaków (char array)
base_text = 'tojestbardzodlugitekstsluzacydotestowaniaalgorytmukodowaniahuffmanazawierajacycyfrytakiejak123orazwieleinnychznakow';
text_seq = repmat(base_text, 1, 10); % Powielenie stworzy teraz płaski wektor o długości 1150 znaków
N_text = length(text_seq);

% Obliczanie częstotliwości w tekście
counts_text = zeros(1, num_symbols);
for i = 1:num_symbols
    counts_text(i) = sum(text_seq == alphabet(i)); % Teraz zadziała bezbłędnie
end
prob_text = counts_text / N_text;

% Usunięcie symboli niewystępujących w tekście
valid_idx_t = prob_text > 0;
symbols_text_valid = symbols(valid_idx_t);
prob_text_valid = prob_text(valid_idx_t);

% Tworzenie słownika
[dict_text, avg_len_text] = huffmandict(symbols_text_valid, prob_text_valid);

% Kodowanie i dekodowanie
sig_text_cell = num2cell(text_seq);
hcode_text = huffmanenco(sig_text_cell, dict_text);
dhsig_text_cell = huffmandeco(hcode_text, dict_text);
decoded_text = cell2mat(dhsig_text_cell);

% Sprawdzenie poprawności
is_equal_text = isequal(text_seq, decoded_text);
disp('--- TEKST NATURALNY ---');
disp(['Czy odkodowany tekst jest identyczny z oryginałem? ', num2str(is_equal_text)]);
disp(['Średnia długość słowa kodowego: ', num2str(avg_len_text), ' bitów/znak']);