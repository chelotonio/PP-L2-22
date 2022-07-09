% TDA CardsSet
% Representación computacional de la generación de cartas
% con sus respectivos símbolos, respetando las restricciones
% correspondientes del juego Dobble.

% Representación: Listas

% Posibles Elements:
% [1, 2, 3, 4, 5, 6, 7]
% ["A", "B", "C", "D","E", "F", "G"]
% ["Arból", "Manzana", "Plátano", "Zorro", "Lana", "Cama", "Silla"]

% _____________ TDA CardsSet - Constructor _____________

% Regla que inserta un elemento dado a una carta.
insertar_en_baraja(Carta, [], [Carta]).
insertar_en_baraja(Carta, Baraja, [Carta|Baraja]).

% Regla que genera una lista a partir de la unión de otras dos.
join( [], Lista, Lista ).
join( [CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado] ) :-
	join( RestoL1, Lista2, ListaResultado ).

% Regla que genera la primera carta.
primeraCarta(0,	FirstCard, FirstCard).
primeraCarta(NumE, Resto, FirstCard) :-
    NumE_i is NumE - 1,
    primeraCarta(NumE_i, [NumE|Resto], FirstCard), !.
    
% Regla que genera una lista con las primeras n cartas de cardsSet.
generar_n_cartas(_n, _n, Lista, Lista).
generar_n_cartas(_i, _n, Lista, Salida):-
    n_carta(_i, 1, _n, [1], Carta),
    insertar_en_baraja(Carta, Lista, Lista2),
    New_i is _i + 1, 
    generar_n_cartas(New_i, _n, Lista2, Salida), !.

% Regla que construye cada carta con la estructura de las primeras n cartas de cardsSet.
n_carta(_, _n, _n, Lista, Lista).
n_carta(_i, _j, _n, Lista, Salida):-
    New_n is _n - 1,
    Num is New_n * _i + (_j + 1),
    insertar_en_baraja(Num, Lista, Lista2),
    New_j is _j + 1, 
    n_carta(_i, New_j, _n, Lista2, Salida), !.

% Regla que genera una lista con las últimas n2 cartas de cardsSet.
generar_n2_cartas(_n, _n, Lista, Lista).
generar_n2_cartas(_i, _n, Lista, Salida):-
    n2_carta(_i, 1, _n, Lista, Carta),
    New_i is _i + 1, 
    generar_n2_cartas(New_i, _n, Carta, Salida), !.

% Regla que genera una lista con parte de las últimas n2 cartas de cardsSet.
n2_carta(_, _n, _n, Lista, Lista).
n2_carta(_i, _j, _n, Lista, Salida):-
    First_i is _i + 1,
    n2_cartas(_i, _j, 1, _n, [First_i], Carta),
    insertar_en_baraja(Carta, Lista, Lista2),
    New_j is _j + 1, 
    n2_carta(_i, New_j, _n, Lista2, Salida), !.

% % Regla que construye cada carta con la estructura de las últimas n2 cartas de cardsSet.
n2_cartas(_, _, _n, _n, Lista, Lista).
n2_cartas(_i, _j, _k, _n, Lista, Salida):-
    New_n is _n - 1,
    Num is (New_n + 2 + New_n * (_k - 1) + (((_i - 1) * (_k - 1) + _j - 1) mod New_n)),
    insertar_en_baraja(Num, Lista, Lista2),
    New_k is _k + 1, 
    n2_cartas(_i, _j, New_k, _n, Lista2, Salida), !.

% cardsSet(3, NumE, MaxC, Seed, CS).
cardsSet(Elements, NumE, MaxC, Seed, CS):-
  primeraCarta(Elements, [], A),
  insertar_en_baraja(A, [], B),
  generar_n_cartas(1, Elements, [], C),
  generar_n2_cartas(1, Elements, [], D),
  join(B, C, E),
  join(E, D, CS), !.

_____________ TDA CardsSet - dobble _____________




% Consultas de ejemplo para cardsSet:
%
%
%




