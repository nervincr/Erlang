-module(server).
-compile(export_all).
-import(lists, [reverse/1,fac/1, fib/1]).

ini() ->
    {ok, Listen} = gen_tcp:listen(2345,
                                [binary, {packet, 4},
                                {reuseaddr, true},
                                {active, true}]),
    spawn(fun() -> par_connect(Listen) end).
    par_connect(Listen) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    spawn(fun() -> par_connect(Listen) end),
    loop(Socket).

loop(Socket) ->
    receive
        {tcp, Socket, Bin} -> 
            io:format("<Server> Binarios recibidos = ~p~n", [Bin]),
            {Func, Val} = binary_to_term(Bin),
            Respuesta = resultado(Func,Val),
            gen_tcp:send(Socket, term_to_binary(Respuesta)),
            loop(Socket);
        {tcp_close, Socket} ->
            io:format("<Server> Socket cerrado~n")
    end.

resultado(Param, Val) when Param == 'fac' ->
    funcion:fac(Val);
resultado(Param, Val) when Param == 'fib' ->
    funcion:fib(Val);
resultado(_, _) ->
    io:format("<Server> Default~n").