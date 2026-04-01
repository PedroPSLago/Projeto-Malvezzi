mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

nome(denis).
nome(joao).
nome(lenin).
nome(otavio).
nome(will).

mes(agosto).
mes(dezembro).
mes(janeiro).
mes(maio).
mes(setembro).

jogo(tres_ou_mais).
jogo(caca_palavras).
jogo(cubo_vermelho).
jogo(jogo_da_forca).
jogo(prob_logica).

materia(biologia).
materia(geografia).
materia(historia).
materia(matematica).
materia(portugues).

suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).
suco(uva).

exatamente_a_esquerda(X, Y, [X, Y | _]).
exatamente_a_esquerda(X, Y, [_ | Resto]) :- 
    exatamente_a_esquerda(X, Y, Resto).

ao_lado(X, Y, Lista) :- exatamente_a_esquerda(X, Y, Lista).
ao_lado(X, Y, Lista) :- exatamente_a_esquerda(Y, X, Lista).

a_esquerda(X, Y, Lista) :- 
    append(_, [X | Resto], Lista), 
    member(Y, Resto).

a_direita(X, Y, Lista) :- 
    a_esquerda(Y, X, Lista).

no_canto(X, [X, _, _, _, _]).
no_canto(X, [_, _, _, _, X]).

modelo(Solucao) :-
    Solucao = [
        (Mochila1, Nome1, Mes1, Jogo1, Materia1, Suco1),
        (Mochila2, Nome2, Mes2, Jogo2, Materia2, Suco2),
        (Mochila3, Nome3, Mes3, Jogo3, Materia3, Suco3),
        (Mochila4, Nome4, Mes4, Jogo4, Materia4, Suco4),
        (Mochila5, Nome5, Mes5, Jogo5, Materia5, Suco5)
    ],

    Suco1 = limao, 
    Suco3 = morango, 
    Jogo3 = jogo_da_forca, 
    Nome5 = lenin,

    member((_, joao, _, _, historia, _), Solucao), 
    member((_, _, _, prob_logica, _, uva), Solucao), 
    member((_, _, _, _, biologia, morango), Solucao), 
    member((_, _, dezembro, _, matematica, maracuja), Solucao), 
    member((azul, _, janeiro, _, _, _), Solucao),

    ao_lado((_, _, setembro, _, _, _), (_, _, _, _, _, laranja), Solucao), 
    a_esquerda((azul, _, _, _, _, _), (_, _, maio, _, _, _), Solucao), 
    ao_lado((_, will, _, _, _, _), (_, _, _, prob_logica, _, _), Solucao), 
    exatamente_a_esquerda((branca, _, _, _, _, _), (_, will, _, _, _, _), Solucao), 
    ao_lado((_, _, _, jogo_da_forca, _, _), (_, _, _, tres_ou_mais, _, _), Solucao), 
    a_direita((_, _, _, _, _, uva), (azul, _, _, _, _, _), Solucao), 
    ao_lado((_, _, janeiro, _, _, _), (_, _, setembro, _, _, _), Solucao), 
    exatamente_a_esquerda((_, _, _, _, _, uva), (_, _, _, _, portugues, _), Solucao), 
    ao_lado((_, _, _, prob_logica, _, _), (amarela, _, _, _, _, _), Solucao), 
    ao_lado((_, _, setembro, _, _, _), (_, _, _, cubo_vermelho, _, _), Solucao), 
    no_canto((_, _, _, cubo_vermelho, _, _), Solucao), 
    ao_lado((_, _, _, jogo_da_forca, _, _), (vermelha, _, _, _, _, _), Solucao), 
    no_canto((_, otavio, _, _, _, _), Solucao),

    mochila(Mochila1), mochila(Mochila2), mochila(Mochila3), mochila(Mochila4), mochila(Mochila5),
    alldifferent([Mochila1, Mochila2, Mochila3, Mochila4, Mochila5]),

    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    alldifferent([Nome1, Nome2, Nome3, Nome4, Nome5]),

    mes(Mes1), mes(Mes2), mes(Mes3), mes(Mes4), mes(Mes5),
    alldifferent([Mes1, Mes2, Mes3, Mes4, Mes5]),

    jogo(Jogo1), jogo(Jogo2), jogo(Jogo3), jogo(Jogo4), jogo(Jogo5),
    alldifferent([Jogo1, Jogo2, Jogo3, Jogo4, Jogo5]),

    materia(Materia1), materia(Materia2), materia(Materia3), materia(Materia4), materia(Materia5),
    alldifferent([Materia1, Materia2, Materia3, Materia4, Materia5]),

    suco(Suco1), suco(Suco2), suco(Suco3), suco(Suco4), suco(Suco5),
    alldifferent([Suco1, Suco2, Suco3, Suco4, Suco5]).

alldifferent([]).
alldifferent([H|T]) :- 
    not(member(H, T)),
    alldifferent(T).

imprime_lista([]) :- write('\n\n FIM do imprime_lista \n').
imprime_lista([H|T]) :-
    write('\n......................................\n'),
    write(H), write(' : '),
    imprime_lista(T).

main :-
    statistics(cputime, T1),
    modelo(Solucao),
    imprime_lista(Solucao),
    statistics(cputime, T2),
    Tempo is T2 - T1,
    format('\nTempo de execucao: ~w segundos\n', [Tempo]),
    fail.

main :-
    write('\nBusca encerrada.\n').
