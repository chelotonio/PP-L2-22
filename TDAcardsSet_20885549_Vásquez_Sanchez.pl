% TDA cardsSet
% TDA que representa la baraja de cartas que se utiliza en el juego Dobble.
% Representación: Listas.

% Metas.

% Hechos.

% Reglas.

% Regla que
% Dominio: Elements (list) X numE(int) X maxC(int) X seed (int) X CS (CardSet)
% Recorrido: CS (CardSet)
cardsSet(Elements, NumE, MaxC, Seed, CS).
% Ejemplo de uso:
% cardsSet([1, 2, 3, 4, 5, 6, 7, … ], 3, 5, 92175, CS).
% CS = [[1, 2, 3], [1, 4, 5], [1, 7, 8], ...]

% Aplicar recursión para generar primera carta.
% Tengo una lista que representa el mazo.
% Se debe crear recursión que genere primera carta y la almacene en la
% lista vacía.
% [] -> [[1, 2, 3]]

% Regla que
% Dominio: NumE (int) X Resto (list) X FirstCard (list)
% Recorrido: FirstCard (list)
% firstCard es una lista con la primera carta
% primeraCarta(5, [], A).
primeraCarta(0,	FirstCard, FirstCard).
primeraCarta(NumE, Resto, FirstCard) :-
    NumE_i is NumE - 1,
    primeraCarta(NumE_i, [NumE|Resto], FirstCard), !.

% Regla que
% Dominio: _j (int) X _k (int) X NumE (int) X Resto (list) X CartaN (list)
% Recorrido: CartaN (list)
% Genera una de las n primeras cartas.
% n_cartas(1, 1, 3, [1], A).
n_cartas(_, NumE, NumE, CartaN, CartaN).
n_cartas(_j, _k, NumE, Resto, CartaN):-
    N is NumE - 1,
    Num is N * _j + (_k + 1),
    New_k is _k + 1,
    n_cartas(_j, New_k, NumE, [Num|Resto], CartaN), !.

% Regla que
% Dominio: _j (int) X NumE (int) X Baraja (list) X B (list)
% Recorrido: B (list)
% Almacena las primeras n cartas en baraja.
n_cartas_in(NumE, NumE, Baraja, Baraja).
n_cartas_in(_j, NumE, BarajaAct, B):-
    n_cartas(_j, 1, NumE, [1], CartaN),
    insertar_en_baraja(CartaN, BarajaAct, BarajaPst),
    New_j is _j + 1,
    n_cartas_in(New_j, NumE, BarajaPst, B), !.

% Regla que
% Dominio: _j (int) X _k (int) X _i (int) X NumE (int) X Resto (list) X CartaN (list)
% Recorrido: CartaN (list)
% Genera una de las n cuadrado primeras cartas.
% n2_cartas(1, 1, 1, 3, [_i + 1], A).
n2_cartas(_, NumE, _, NumE, CartaN, CartaN).
n2_cartas(_j, _k, _i, NumE, Resto, CartaN):-
    N is NumE - 1,
    Num is (N + 2 + N * (_k - 1) + (((_i - 1) * (_k - 1) + _j - 1) mod N)),
    New_k is _k + 1,
    n2_cartas(_j, New_k, _i, NumE, [Num|Resto], CartaN), !.

% Regla que
% Dominio: _j (int) X _i (int) X NumE (int) X BarajaAct (list) X Baraja (list)
% Recorrido: Baraja (list)
% Almacena las primeras n cuadrado cartas en baraja.
% n2_cartas_in(1, 1, 3, [], B).
n2_cartas_in(NumE, NumE, NumE, Baraja, Baraja).
n2_cartas_in(NumE, _, NumE, Baraja, Baraja).
n2_cartas_in(_j, _i, NumE, BarajaAct, B):-
    n2_cartas(_j, 1, _i, NumE, [_i + 1], CartaN),
    insertar_en_baraja(CartaN, BarajaAct, BarajaPst),
    New_j is _j + 1,
    n2_cartas_in(New_j, _i, NumE, BarajaPst, B),
    New_i is _i + 1,
    n2_cartas_in(1, New_i, NumE, BarajaPst, B), !.



% Consultas (Ejemplos de uso de predicados).
% cardsSet([1, 2, 3, 4, 5, 6, 7], 3, 5, 92175, CS).
% cardsSet(["arbol", "lapiz", "manzana", "carton", "caja", "zapato", "mochila"], 4, 7, 92175, CS).
% cardsSet(["a", "b", "c", "d", "e", "f", "g"], 2, 1, 92175, CS).
