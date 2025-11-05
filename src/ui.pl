% ui.pl - Interface de coleta de dados do usuário

:- dynamic obs/1.

% Predicado auxiliar para perguntas sim/não
pergunta_sim_nao(Campo, Texto) :-
    format("~w (s/n): ", [Texto]),
    read(Ans0),
    downcase_atom(Ans0, Ans),
    ( Ans == s ->
        Term =.. [Campo, sim],
        assertz(obs(Term))
    ; Ans == n ->
        Term =.. [Campo, nao],
        assertz(obs(Term))
    ; 
        format("Entrada invalida. Digite 's' ou 'n'.~n"),
        pergunta_sim_nao(Campo, Texto)
    ).

% Coleta todos os dados necessários do funcionário
coletar_dados_funcionario :-
    % Dados básicos
    format("Nome do funcionario: "),
    read(Nome),
    assertz(obs(nome(Nome))),
    
    format("Cargo: "),
    read(Cargo),
    assertz(obs(cargo(Cargo))),
    
    % Salário base
    format("Salario base (R$): "),
    read(SalBase),
    ( number(SalBase), SalBase > 0 ->
        assertz(obs(salario_base(SalBase)))
    ;
        format("Valor invalido! Digite um numero positivo.~n"),
        fail
    ),
    
    % Horas extras
    format("Horas extras trabalhadas no mes: "),
    read(HE),
    ( number(HE), HE >= 0 ->
        assertz(obs(horas_extras(HE)))
    ;
        format("Valor invalido!~n"),
        fail
    ),
    
    % Adicional noturno
    pergunta_sim_nao(trabalho_noturno, "Trabalha em horario noturno?"),
    
    % Insalubridade
    format("Grau de insalubridade (minimo/medio/maximo/nao): "),
    read(Insalub0),
    downcase_atom(Insalub0, Insalub),
    ( member(Insalub, [minimo, medio, maximo, nao]) ->
        assertz(obs(insalubridade(Insalub)))
    ;
        format("Opcao invalida! Use: minimo, medio, maximo ou nao~n"),
        fail
    ),
    
    % Desempenho
    format("Avaliacao de desempenho (excelente/bom/regular/nao): "),
    read(Desemp0),
    downcase_atom(Desemp0, Desemp),
    ( member(Desemp, [excelente, bom, regular, nao]) ->
        assertz(obs(desempenho(Desemp)))
    ;
        format("Opcao invalida!~n"),
        fail
    ),
    
    % Dependentes
    format("Numero de dependentes para IR: "),
    read(Dep),
    ( integer(Dep), Dep >= 0 ->
        assertz(obs(dependentes(Dep)))
    ;
        format("Valor invalido!~n"),
        fail
    ),
    
    % Vale transporte
    pergunta_sim_nao(vale_transporte, "Utiliza vale transporte?"),
    
    ( obs(vale_transporte(sim)) ->
        format("Valor mensal do vale transporte (R$): "),
        read(VT),
        ( number(VT), VT >= 0 ->
            assertz(obs(valor_vt(VT)))
        ;
            assertz(obs(valor_vt(0)))
        )
    ;
        assertz(obs(valor_vt(0)))
    ),
    
    format("~nDados coletados com sucesso!~n~n").

% Limpa todas as observações após o cálculo
cleanup :- 
    retractall(obs(_)).