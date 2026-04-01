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

jogo(caca_palavras).
jogo(cubo_vermelho).
jogo(jogo_da_forca).
jogo(prob_logica).
jogo(tres_ou_mais).

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

alldifferent([]).
alldifferent([H|T]) :- 
    not(member(H, T)), 
    alldifferent(T).

imprime_lista([]) :- 
    write('\n\n FIM do imprime_lista \n').
imprime_lista([H|T]) :-
    write('\n......................................\n'),
    write(H), write(' : '),
    imprime_lista(T).

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
        (Mochila_1, Nome_1, Mes_1, Jogo_1, Materia_1, Suco_1),
        (Mochila_2, Nome_2, Mes_2, Jogo_2, Materia_2, Suco_2),
        (Mochila_3, Nome_3, Mes_3, Jogo_3, Materia_3, Suco_3),
        (Mochila_4, Nome_4, Mes_4, Jogo_4, Materia_4, Suco_4),
        (Mochila_5, Nome_5, Mes_5, Jogo_5, Materia_5, Suco_5)
    ],

    Suco_1 = limao, 
    Suco_3 = morango, 
    Jogo_3 = jogo_da_forca, 
    Nome_5 = lenin,

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

    mochila(Mochila_1), mochila(Mochila_2), mochila(Mochila_3), mochila(Mochila_4), mochila(Mochila_5),
    alldifferent([Mochila_1, Mochila_2, Mochila_3, Mochila_4, Mochila_5]),

    nome(Nome_1), nome(Nome_2), nome(Nome_3), nome(Nome_4), nome(Nome_5),
    alldifferent([Nome_1, Nome_2, Nome_3, Nome_4, Nome_5]),

    mes(Mes_1), mes(Mes_2), mes(Mes_3), mes(Mes_4), mes(Mes_5),
    alldifferent([Mes_1, Mes_2, Mes_3, Mes_4, Mes_5]),

    jogo(Jogo_1), jogo(Jogo_2), jogo(Jogo_3), jogo(Jogo_4), jogo(Jogo_5),
    alldifferent([Jogo_1, Jogo_2, Jogo_3, Jogo_4, Jogo_5]),

    materia(Materia_1), materia(Materia_2), materia(Materia_3), materia(Materia_4), materia(Materia_5),
    alldifferent([Materia_1, Materia_2, Materia_3, Materia_4, Materia_5]),

    suco(Suco_1), suco(Suco_2), suco(Suco_3), suco(Suco_4), suco(Suco_5),
    alldifferent([Suco_1, Suco_2, Suco_3, Suco_4, Suco_5]).

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
