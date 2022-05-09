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

primeraCarta(0,	FirstCard, FirstCard).
primeraCarta(NumE, Resto, FirstCard) :-
    NumE_i is NumE - 1,
    primeraCarta(NumE_i, [NumE|Resto], FirstCard), !.

% Consultas.
