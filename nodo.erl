-module(nodo).
-export([iniciar/0, iniciar_fib/0, calcular/1]).

iniciar() -> register(nodo, spawn(fun() -> loop() end)).
iniciar_fib() -> register(nodo, spawn(fun() -> loop_fib() end)).

calcular(Valor) -> rpc({calcular, Valor}).

rpc(Q) ->
    nodo ! {self(), Q},
    receive
        {nodo, Respuesta} ->
            Respuesta
    end.

loop() ->
    receive
        {From, {calcular, Valor}} ->
            From ! {nodo, {ok, funcion:fac(Valor)}},
            loop()
    end.

loop_fib() ->
    receive
        {From, {calcular, Valor}} ->
            From ! {nodo, {ok, funcion:fib(Valor)}},
            loop_fib()
    end.
