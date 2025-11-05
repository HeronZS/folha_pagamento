% explain.pl - Explicação detalhada dos cálculos realizados

% Predicado principal de explicação
explicar(resultado(
    salario_bruto(Bruto),
    proventos(Proventos),
    descontos(Descontos),
    salario_liquido(Liquido)
)) :-
    format("~n===============================================~n"),
    format("           HOLERITE - FOLHA DE PAGAMENTO~n"),
    format("===============================================~n~n"),
    
    % Dados do funcionário
    exibir_dados_funcionario,
    
    % Composição do salário bruto
    format("~n--- COMPOSICAO DO SALARIO BRUTO ---~n"),
    obs(salario_base(Base)),
    format("Salario Base: R$ ~2f~n", [Base]),
    
    calcular_horas_extras(HE),
    ( HE > 0 ->
        obs(horas_extras(Horas)),
        format("Horas Extras (~w horas): R$ ~2f~n", [Horas, HE]),
        format("  -> Regra: Valor hora (Base/220) * Horas * 1.5~n")
    ; true ),
    
    calcular_adicional_noturno(AN),
    ( AN > 0 ->
        format("Adicional Noturno (20%%): R$ ~2f~n", [AN]),
        format("  -> Regra: 20%% sobre salario base~n")
    ; true ),
    
    calcular_insalubridade(Insalub),
    ( Insalub > 0 ->
        obs(insalubridade(Grau)),
        format("Insalubridade (~w): R$ ~2f~n", [Grau, Insalub]),
        format("  -> Regra: Percentual sobre salario minimo~n")
    ; true ),
    
    format("~nSALARIO BRUTO: R$ ~2f~n", [Bruto]),
    
    % Proventos
    format("~n--- PROVENTOS ---~n"),
    ( Proventos > 0 ->
        obs(desempenho(Tipo)),
        bonus_desempenho(Tipo, Perc),
        PercDisplay is Perc * 100,
        format("Bonus por Desempenho (~w - ~w%%): R$ ~2f~n", [Tipo, PercDisplay, Proventos]),
        format("  -> Regra: Percentual sobre salario base conforme avaliacao~n")
    ;
        format("Sem bonus neste mes~n")
    ),
    
    % Descontos
    format("~n--- DESCONTOS ---~n"),
    calcular_inss(INSS),
    format("INSS: R$ ~2f~n", [INSS]),
    format("  -> Regra: Calculo progressivo por faixas de contribuicao~n"),
    
    calcular_irrf(IRRF),
    format("IRRF: R$ ~2f~n", [IRRF]),
    obs(dependentes(Dep)),
    format("  -> Regra: Base = Bruto - INSS - Dependentes (~w)~n", [Dep]),
    format("  -> Aplicada aliquota progressiva com deducao~n"),
    
    calcular_vale_transporte(VT),
    ( VT > 0 ->
        format("Vale Transporte (6%%): R$ ~2f~n", [VT]),
        format("  -> Regra: 6%% sobre salario base, limitado ao valor do VT~n")
    ; true ),
    
    format("~nTOTAL DESCONTOS: R$ ~2f~n", [Descontos]),
    
    % Salário líquido
    format("~n===============================================~n"),
    format("SALARIO LIQUIDO: R$ ~2f~n", [Liquido]),
    format("===============================================~n"),
    format("  -> Regra: Bruto + Proventos - Descontos~n"),
    
    % Resumo das regras aplicadas
    exibir_resumo_regras.

% Exibe dados básicos do funcionário
exibir_dados_funcionario :-
    obs(nome(Nome)),
    obs(cargo(Cargo)),
    format("Funcionario: ~w~n", [Nome]),
    format("Cargo: ~w~n", [Cargo]).

% Exibe resumo das regras acionadas
exibir_resumo_regras :-
    format("~n--- REGRAS ACIONADAS ---~n"),
    format("1. Calculo de Salario Bruto (base + adicionais)~n"),
    
    ( obs(horas_extras(H)), H > 0 ->
        format("2. Calculo de Horas Extras~n")
    ; true ),
    
    ( obs(trabalho_noturno(sim)) ->
        format("3. Calculo de Adicional Noturno~n")
    ; true ),
    
    ( obs(insalubridade(G)), G \= nao ->
        format("4. Calculo de Insalubridade~n")
    ; true ),
    
    ( obs(desempenho(D)), D \= nao ->
        format("5. Calculo de Bonus por Desempenho~n")
    ; true ),
    
    format("6. Calculo de Descontos Totais~n"),
    format("7. Calculo Progressivo de INSS~n"),
    format("8. Calculo Progressivo de IRRF~n"),
    
    ( obs(vale_transporte(sim)) ->
        format("9. Calculo de Vale Transporte~n")
    ; true ),
    
    format("10. Calculo de Salario Liquido~n").