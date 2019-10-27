-module(client).
-compile(export_all).
-import(list,[reverse/1]).

enviar(Param) -> 
	{ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
	ok = gen_tcp:send(Socket, term_to_binary(Param)),
	receive 
		{tcp, Socket, Bin} ->
			io:format("<Cliente> Binarios recibidos = ~p~n", [Bin]),
			Respuesta = binary_to_term(Bin),
			io:format("<Cliente> Respuesta = ~p~n", [Respuesta]),
			gen_tcp:close(Socket)
	end.
            
