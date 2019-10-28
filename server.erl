-module(server).
-compile(export_all).
-import(lists, [reverse/1,fac/1, fib/1]).

iniciar_server() ->
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
            %Val = binary_to_term(Bin),
            %Respuesta = funcion:fac(Val),
            {Opc, Val} = binary_to_term(Bin),            
            Respuesta = operación(Opc,Val),
            gen_tcp:send(Socket, term_to_binary(Respuesta)),
            loop(Socket);
        {tcp_close, Socket} ->
            io:format("<Server> Socket cerrado~n")
    end.

operación(Opc, Val) when Opc == 'fact' ->
    funcion:fac(Val);
operación(Opc, Val) when Opc == 'fibo' ->
    funcion:fib(Val);
operación(_, _) ->
    io:format("<Server> Opción Inválida!~n").