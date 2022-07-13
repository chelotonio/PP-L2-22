% TDA game
% Representación computacional del juego Dobble
% con sus respectiva baraja, jugadores, modo de juego,
% y parámetros necesarios para el desarrollo del juego.

% Representación: Listas

%% SE RECOMIENDA COMPROBAR LOS EJEMPLOS DE DOBBLEGAME PRESENTES EN TDACARDSSET COMO CONSULTAS DE TDACARDSSET DEBIDO A PROBLEMAS CON LA IMPORTACIÓN DE MODULOS DESDE OTROS ARCHIVOS.

% Regla que construye un juego de Dobble.
% Dominio: numPlayers (int) X cardsSet X mode (string) X seed (int) X game (TDAgame)
% Recorrido: game (TDAgame)
dobbleGame(NumPlayers, CardsSet, Mode, Seed, [NumPlayers, CardsSet, Mode, Seed]).

% _____________ Consultas _____________

% Consultas de ejemplo para dobbleGame:
% dobbleGame(2, [[1, 2], [2, 3], [1, 3]], "Player vs Player", 34235, G1).
% dobbleGame(2, [["Árbol", "Casa"], ["Casa", "Pato"], ["Árbol", "Pato"]], "1v1v1", 34235, G2).
% dobbleGame(2, [["a", "b", "c"], ["a", "d", "e"], ["a", "f", "g"]], "Player vs IA", 34235, G3).
