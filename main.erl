-module(main).
-export([iniciar/0]).

iniciar() ->
    EstadoInicial = least_mean_square:novo_estado(),
    Entrada = 10,
    {Saida, NovoEstado} = least_mean_square:processar(Entrada, EstadoInicial),
    io:format("Entrada: ~p~n", [Entrada]),
    io:format("Saída: ~p~n", [Saida]),
    io:format("Novo Estado: ~p~n", [NovoEstado]),
    iniciar_recursivo(NovoEstado, Entrada * 2, 1).

iniciar_recursivo(EstadoAtual, Entrada, Contador) when Contador < 10 ->
    EntradaLimitada = min(255, Entrada),
    {Saida, NovoEstado} = least_mean_square:processar(EntradaLimitada, EstadoAtual),
    io:format("Entrada: ~p~n", [EntradaLimitada]),
    io:format("Saída: ~p~n", [Saida]),
    io:format("Novo Estado: ~p~n", [NovoEstado]),
    iniciar_recursivo(NovoEstado, Entrada * 2, Contador + 1);
iniciar_recursivo(_, _, _) ->
    io:format("Processamento concluído.~n"),
    ok.