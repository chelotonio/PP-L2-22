% TDA cardsSet
% TDA que representa la baraja de cartas que se utiliza en el juego Dobble.
% Representación: Listas.

% Atoms.

% Hechos.

% Reglas.

cardsSet(Elements, NumE, MaxC, Seed, CS).
% Ejemplo de uso:
% cardsSet([1, 2, 3, 4, 5, 6, 7, … ], 3, 5, 92175, CS).
% CS = [[1, 2, 3], [1, 4, 5], [1, 7, 8], ...]

% Aplicar recursión para generar primera carta.
% Tengo una lista que representa el mazo.
% Se debe crear recursión que genere primera carta y la almacene en la
% lista vacía.
% [] -> [[1, 2, 3]]

% firstCard es una lista con la primera carta
% primeraCarta(5, [], A).
primeraCarta(0,	FirstCard, FirstCard).
primeraCarta(NumE, Resto, FirstCard) :-
    NumE_i is NumE - 1,
    primeraCarta(NumE_i, [NumE|Resto], FirstCard), !.

% Genera una de las n primeras cartas.
% n_cartas(1, 1, 3, [1], A).
n_cartas(_, NumE, NumE, CartaN, CartaN).
n_cartas(_j, _k, NumE, Resto, CartaN):-
    N is NumE - 1,
    Num is N * _j + (_k + 1),
    New_k is _k + 1,
    n_cartas(_j, New_k, NumE, [Num|Resto], CartaN), !.

% Almacena las primeras n cartas en baraja.
n_cartas_in(NumE, NumE, Baraja, Baraja).
n_cartas_in(_j, NumE, BarajaAct, B):-
    n_cartas(_j, 1, NumE, [1], CartaN),
    insertar_en_baraja(CartaN, BarajaAct, BarajaPst),
    New_j is _j + 1,
    n_cartas_in(New_j, NumE, BarajaPst, B), !.

% Consultas.
