% TDA CardsSet
% Representación computacional de la generación de cartas
% con sus respectivos símbolos, respetando las restricciones
% correspondientes del juego Dobble.

% Representación: Listas

% Posibles Elements:
% [1, 2, 3, 4, 5, 6, 7]
% ["A", "B", "C", "D","E", "F", "G"]
% ["Arból", "Manzana", "Plátano", "Zorro", "Lana", "Cama", "Silla"]

myRandom(Xn, Xn1):-
AX is 1103515245 * Xn,
AXC is AX + 12345,
Xn1 is (AXC mod 2147483647).

% _____________ TDA CardsSet - Constructor _____________

contarLista([], _i, _i).
contarLista([_|Resto], _i, Salida):-
    New_i is _i + 1,
    contarLista(Resto, New_i, Salida).

% Regla que inserta un elemento dado a una carta.
insertar_en_baraja(Carta, [], [Carta]).
insertar_en_baraja(Carta, Baraja, [Carta|Baraja]).

% Regla que acota la cantidad de cartas presentes en cardsSet.
% acotarCartas(CardsSet, E, CardsSetAc).
acotarCartas(_, 0, Lista, Lista).
acotarCartas([Cabeza|Resto], E, Lista, Salida):-
    insertar_en_baraja(Cabeza, Lista, NuevaLista),
	NewE is E - 1,
	acotarCartas(Resto, NewE, NuevaLista, Salida), !.
acotarCartas(CardsSet, -1, _, Salida):-
    acotarCartas(_, 0, CardsSet, Salida).

% Regla que entrega el enésimo elemento de una lista.
buscarElemento([Cabeza|_], 0, Cabeza).
buscarElemento([_|Cabeza], Posicion, Elemento) :- 
	PosicionAnterior is Posicion-1,
	buscarElemento(Cabeza, PosicionAnterior, Elemento).

% Regla que genera una lista a partir de la unión de otras dos.
join([], Lista, Lista).
join([CabezaL1|RestoL1], Lista2, [CabezaL1|ListaResultado]) :-
	join(RestoL1, Lista2, ListaResultado).

% Regla que genera la primera carta.
primeraCarta(_, 0,	FirstCard, FirstCard).
primeraCarta(Elements, NumE, Resto, FirstCard) :-
    NumE_i is NumE - 1,
    buscarElemento(Elements, NumE_i, A),
    primeraCarta(Elements, NumE_i, [A|Resto], FirstCard), !.
    
% Regla que genera una lista con las primeras n cartas de cardsSet.
generar_n_cartas(_, _n, _n, Lista, Lista).
generar_n_cartas(Elements, _i, _n, Lista, Salida):-
    buscarElemento(Elements, 0, A),
    n_carta(Elements, _i, 1, _n, [A], Carta),
    insertar_en_baraja(Carta, Lista, Lista2),
    New_i is _i + 1, 
    generar_n_cartas(Elements, New_i, _n, Lista2, Salida), !.

% Regla que construye cada carta con la estructura de las primeras n cartas de cardsSet.
n_carta(_, _, _n, _n, Lista, Lista).
n_carta(Elements, _i, _j, _n, Lista, Salida):-
    New_n is _n - 1,
    Num is New_n * _i + (_j + 1),
    NewNum is Num - 1,
    buscarElemento(Elements, NewNum, A),
    insertar_en_baraja(A, Lista, Lista2),
    New_j is _j + 1, 
    n_carta(Elements, _i, New_j, _n, Lista2, Salida), !.

% Regla que genera una lista con las últimas n2 cartas de cardsSet.
generar_n2_cartas(_, _n, _n, Lista, Lista).
generar_n2_cartas(Elements, _i, _n, Lista, Salida):-
    n2_carta(Elements, _i, 1, _n, Lista, Carta),
    New_i is _i + 1, 
    generar_n2_cartas(Elements, New_i, _n, Carta, Salida), !.

% Regla que genera una lista con parte de las últimas n2 cartas de cardsSet.
n2_carta(_, _, _n, _n, Lista, Lista).
n2_carta(Elements, _i, _j, _n, Lista, Salida):-
    buscarElemento(Elements, _i, A),
    n2_cartas(Elements, _i, _j, 1, _n, [A], Carta),
    insertar_en_baraja(Carta, Lista, Lista2),
    New_j is _j + 1, 
    n2_carta(Elements, _i, New_j, _n, Lista2, Salida), !.

% % Regla que construye cada carta con la estructura de las últimas n2 cartas de cardsSet.
n2_cartas(_, _, _, _n, _n, Lista, Lista).
n2_cartas(Elements, _i, _j, _k, _n, Lista, Salida):-
    New_n is _n - 1,
    Num is (New_n + 2 + New_n * (_k - 1) + (((_i - 1) * (_k - 1) + _j - 1) mod New_n)),
    NewNum is Num - 1,
    buscarElemento(Elements, NewNum, A),
    insertar_en_baraja(A, Lista, Lista2),
    New_k is _k + 1, 
    n2_cartas(Elements, _i, _j, New_k, _n, Lista2, Salida), !.

% Función que
% Dominio:
% Recorrido:
cardsSet(Elements, NumE, MaxC, Seed, CS):-
  primeraCarta(Elements, NumE, [], A),
  insertar_en_baraja(A, [], B),
  generar_n_cartas(Elements, 1, NumE, [], C),
  generar_n2_cartas(Elements, 1, NumE, [], D),
  join(B, C, E),
  join(E, D, F),
  acotarCartas(F, MaxC, [], CS), !.

% _____________ TDA CardsSet - dobble _____________

% Regla que cuenta la cantidad de veces que se repite un elemento en una lista.
contarRepetidosAux(_, [], Repetidos, Repetidos).
contarRepetidosAux(E, [E|Resto], Cuenta, Salida):-
	N_cuenta is Cuenta + 1,
    contarRepetidosAux(E, Resto, N_cuenta, Salida), !.
contarRepetidosAux(E, [_|Resto], Cuenta, Salida):-
    contarRepetidosAux(E, Resto, Cuenta, Salida), !.

% Regla que cuenta la cantidad de elementos de una carta que se repiten en otra carta.
contarRepetidos([], _, SumaCuentas, SumaCuentas).
contarRepetidos([Elemento|Resto], Carta2, SumaCuentas, Salida):-
    contarRepetidosAux(Elemento, Carta2, 0, Cuenta),
    Ncuenta is SumaCuentas + Cuenta,
    contarRepetidos(Resto, Carta2, Ncuenta, Salida), !.
contarRepetidos([_|[]], _, SumaCuentas, Salida):-
    contarRepetidos([], _, SumaCuentas, Salida), !.

% Regla que permite verificar si el conjunto de cartas en el TDA corresponden a un conjunto válido.
% Dominio: CardsSet (Lista)
% Salida: Boolean
cardsSetIsDobble([]).
cardsSetIsDobble([Carta1|Resto]):-
    buscarElemento(Resto, 0, Carta2),
    contarRepetidos(Carta1, Carta2, 0, Cuenta),
    Cuenta = 1,
    cardsSetIsDobble(Resto), !.
cardsSetIsDobble([_|[]]):-
    cardsSetIsDobble([]), !.

% _____________ TDA CardsSet - nthCard _____________

% Regla que obtiene la n-ésima (nth) carta desde el conjunto de cartas partiendo desde 0 hasta (totalCartas-1).
% Dominio: CardsSet (lista) X n (int) X Card (lista)
% Recorrido: Card (lista)
cardsSetNthCard(CardsSet, N, Card):-
    NewN is N - 1,
    buscarElemento(CardsSet, NewN, Card), !.

% _____________ TDA CardsSet - nthCard _____________

% Regla que a partir de una carta de muestra, determina la cantidad total de cartas que se deben producir para construir un conjunto válido.
% Dominio:
% Recorrido: 
cardsSetFindTotalCards(Card, Total):-
    contarLista(Card, 0, A), 
    Total is ((A - 1) * (A - 1)) + (A - 1) + 1.

% _____________ TDA CardsSet - missingCards _____________



% _____________ Consultas _____________

% Consultas de ejemplo para cardsSet:
% cardsSet(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"], 4, 10, 912321, CS).
% cardsSet(["Arból", "Manzana", "Plátano", "Zorro", "Lana", "Cama", "Silla"], 3, -1, 84392, CS).
% cardsSet([1, 2, 3, 4, 5, 6, 7], 2, 3, 912321, CS).


% Consultas de ejemplo para dobble?:
% CS = [[1, 2, 3], [1, 4, 5], [1, 6, 7], [1, 7, 8]], cardsSetIsDobble(CS). % CardsSet inválido

% Para un caso verdadero, prolog retorna por defecto el propio cardsSet que se genera: 
% cardsSet(["Arból", "Manzana", "Plátano", "Zorro", "Lana", "Cama", "Silla"], 3, 3,84392, CS), cardsSetIsDobble(CS).
% Para recibir True se ingresa el maso creado por cardsSet directamente: 
% cardsSetIsDobble([["Lana", "Zorro", "Arból"], ["Silla", "Cama", "Arból"], ["Arból", "Manzana", "Plátano"]]).

% Para un caso verdadero, prolog retorna por defecto el propio cardsSet que se genera: 
% cardsSet(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"], 4, 4, 912321, CS), cardsSetIsDobble(CS).
% Para recibir True se ingresa el maso creado por cardsSet directamente: 
% cardsSetIsDobble([["G", "F", "E", "A"], ["J", "I", "H", "A"], ["M", "L", "K", "A"], ["A", "B", "C", "D"]]). 

% Consultas de ejemplo para nthCard:
% cardsSet([1, 2, 3, 4, 5, 6, 7], 2, 3, 912321, CS), cardsSetNthCard(CS, 3, Card3).
% cardsSet(["Arból", "Manzana", "Plátano", "Zorro", "Lana", "Cama", "Silla"], 3, -1, 84392, CS), cardsSetNthCard(CS, 6, Card6).
% cardsSet(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"], 4, 10, 912321, CS), cardsSetNthCard(CS, 9, Card9).

% Consultas de ejemplo para findTotalCards:
% cardsSet(["Arból", "Manzana", "Plátano", "Zorro", "Lana", "Cama", "Silla"], 3, -1, 84392, CS), cardsSetNthCard(CS, 6, Card6), cardsSetFindTotalCards(Card6, Total).
% cardsSet(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"], 4, 10, 912321, CS), cardsSetNthCard(CS, 9, Card9), cardsSetFindTotalCards(Card9, Total).
% cardsSet([1, 2, 3, 4, 5, 6, 7], 2, 2, 912321, CS), cardsSetNthCard(CS, 2, Card2), cardsSetFindTotalCards(Card3, Total).

% Consultas de ejemplo para missingCards:


