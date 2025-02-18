-module(least_mean_square).
-export([processar/2, novo_estado/0]).

-record(state, {
    coeficientes = 0 :: non_neg_integer(), % Coeficientes do filtro adaptativo (inicializados com 0)
    acumulador = 0 :: integer(),           % Acumulador para cálculo dos coeficientes
    mu = 0.01                              % Taxa de aprendizado do LMS
}).

novo_estado() ->
    #state{}.

processar(Entrada, State) when is_integer(Entrada), Entrada >= 0, Entrada =< 255 ->
    X = Entrada,
    Y = State#state.coeficientes,
    Erro = X - Y,

    % Atualizar o acumulador
    NovoAcumulador = State#state.acumulador + Erro * X,

    % Atualizar os coeficientes
    NovosCoeficientes = State#state.coeficientes + round(State#state.mu * NovoAcumulador),

    % Limitar os coeficientes ao intervalo de 8 bits (0 a 255)
    CoeficientesLimitados = max(0, min(255, NovosCoeficientes)),

    % Retornar a saída e o novo estado
    {Y, State#state{
        acumulador = NovoAcumulador,
        coeficientes = CoeficientesLimitados
    }}.