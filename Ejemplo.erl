-module(ejemplo).
-export([mostrar/1, reversar/1, palindromo/1]).

mostrar(Palabra) ->
    io:fwrite("Hola: ~p~n", [Palabra]).

reversar(L) -> reversar(L,[]).

reversar([],Acumulador) -> Acumulador;
reversar([Inicio|Fin],Acumulador) -> reversar(Fin,[Inicio|Acumulador]).

palindromo(L) -> reversar(L) == L.

% Nervin Quesada Mora
% Kevin Hernández Arias
% Laboratorio #3

