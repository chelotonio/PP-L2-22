%cardsSet(Elements, NumE, MaxC, Seed, CS).
% Ejemplo de uso:
% cardsSet([1, 2, 3, 4, 5, 6, 7, … ], 3, 5, 92175, CS).
% CS = [[1, 2, 3], [1, 4, 5], [1, 7, 8], ...]

% Aplicar recursión para generar primera carta.
% Tengo una lista que representa el mazo.
% Se debe crear recursión que genere primera carta y la almacene en la
% lista vacía.
% [] -> [[1, 2, 3]]

insertar_en_baraja(Carta, [], [Carta]).
insertar_en_baraja(Carta, Baraja, [Carta|Baraja]).

join( [], Lista, Lista ).
join( [CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado] ) :-
	join( RestoL1, Lista2, ListaResultado ).

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
% n_cartas_in(1, 4, [], B).
n_cartas_in(NumE, NumE, Baraja, Baraja).
n_cartas_in(_j, NumE, BarajaAct, B):-
    n_cartas(_j, 1, NumE, [1], CartaN),
    insertar_en_baraja(CartaN, BarajaAct, BarajaPst),
    New_j is _j + 1,
    n_cartas_in(New_j, NumE, BarajaPst, B), !.
    

% Genera una de las n cuadrado primeras cartas.

% __________1ras n cartas______________

% generar_n_cartas(1, 3, [], A)
% for(1, 4, [], A).
generar_n_cartas(_n, _n, Lista, Lista).
generar_n_cartas(_i, _n, Lista, Salida):-
    n_carta(_i, 1, _n, [1], Carta),
    insertar_en_baraja(Carta, Lista, Lista2),
    New_i is _i + 1, 
    generar_n_cartas(New_i, _n, Lista2, Salida), !.

% generar_n_cartas(1, 3, [], A).
% for2(1, 1, 3, [1], A).
n_carta(_, _n, _n, Lista, Lista).
n_carta(_i, _j, _n, Lista, Salida):-
    New_n is _n - 1,
    Num is New_n * _i + (_j + 1),
    insertar_en_baraja(Num, Lista, Lista2),
    New_j is _j + 1, 
    n_carta(_i, New_j, _n, Lista2, Salida), !.

% ____________1ras n2 cartas____________

generar_n2_cartas(_n, _n, Lista, Lista).
generar_n2_cartas(_i, _n, Lista, Salida):-
    n2_carta(_i, 1, _n, Lista, Carta),
    New_i is _i + 1, 
    generar_n2_cartas(New_i, _n, Carta, Salida), !.

% for2(1, 1, 3, [1], A).
n2_carta(_, _n, _n, Lista, Lista).
n2_carta(_i, _j, _n, Lista, Salida):-
    First_i is _i + 1,
    n2_cartas(_i, _j, 1, _n, [First_i], Carta),
    insertar_en_baraja(Carta, Lista, Lista2),
    New_j is _j + 1, 
    n2_carta(_i, New_j, _n, Lista2, Salida), !.

n2_cartas(_, _, _n, _n, Lista, Lista).
n2_cartas(_i, _j, _k, _n, Lista, Salida):-
    New_n is _n - 1,
    Num is (New_n + 2 + New_n * (_k - 1) + (((_i - 1) * (_k - 1) + _j - 1) mod New_n)),
    insertar_en_baraja(Num, Lista, Lista2),
    New_k is _k + 1, 
    n2_cartas(_i, _j, New_k, _n, Lista2, Salida), !.

% ____________cardsSet_____________

% cardsSet(3, NumE, MaxC, Seed, CS).
cardsSet(Elements, NumE, MaxC, Seed, CS):-
primeraCarta(Elements, [], A),
insertar_en_baraja(A, [], B),
generar_n_cartas(1, Elements, [], C),
generar_n2_cartas(1, Elements, [], D),
join(B, C, E),
join(E, D, CS), !.




% Consultas.