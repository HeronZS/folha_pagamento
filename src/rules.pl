% rules.pl - Regras de negócio para cálculo da folha

:- dynamic obs/1.

% Meta principal: retorna resultado completo da folha de pagamento
meta(resultado(
    salario_bruto(Bruto),
    proventos(Proventos),
    descontos(Descontos),
    salario_liquido(Liquido)
)) :-
    calcular_salario_bruto(Bruto),
    calcular_proventos(Proventos),
    calcular_descontos(Descontos),
    calcular_salario_liquido(Bruto, Proventos, Descontos, Liquido).

/* ===== REGRA 1: Cálculo do Salário Bruto ===== */
% Salário bruto = salário base + horas extras + adicional noturno + insalubridade
calcular_salario_bruto(Bruto) :-
    obs(salario_base(Base)),
    calcular_horas_extras(HorasExtras),
    calcular_adicional_noturno(AdicNoturno),
    calcular_insalubridade(Insalub),
    Bruto is Base + HorasExtras + AdicNoturno + Insalub.

/* ===== REGRA 2: Cálculo de Horas Extras ===== */
% Horas extras = (salário base / 220) * horas * 1.5
calcular_horas_extras(Valor) :-
    obs(salario_base(Base)),
    obs(horas_extras(Horas)),
    Horas > 0,
    ValorHora is Base / 220,
    Valor is ValorHora * Horas * 1.5, !.
calcular_horas_extras(0).

/* ===== REGRA 3: Cálculo de Adicional Noturno ===== */
% Adicional noturno = 20% sobre o salário base (se trabalha à noite)
calcular_adicional_noturno(Valor) :-
    obs(trabalho_noturno(sim)),
    obs(salario_base(Base)),
    adicional_noturno(Percentual),
    Valor is Base * Percentual, !.
calcular_adicional_noturno(0).

/* ===== REGRA 4: Cálculo de Insalubridade ===== */
% Insalubridade = percentual sobre salário mínimo conforme grau
calcular_insalubridade(Valor) :-
    obs(insalubridade(Grau)),
    Grau \= nao,
    insalubridade_grau(Grau, Percentual),
    salario_minimo(SM),
    Valor is SM * Percentual, !.
calcular_insalubridade(0).

/* ===== REGRA 5: Cálculo de Proventos (Bônus) ===== */
% Proventos = bônus por desempenho sobre salário base
calcular_proventos(Proventos) :-
    obs(salario_base(Base)),
    obs(desempenho(Tipo)),
    bonus_desempenho(Tipo, Percentual),
    Proventos is Base * Percentual.

/* ===== REGRA 6: Cálculo Total de Descontos ===== */
% Descontos = INSS + IRRF + Vale Transporte
calcular_descontos(Total) :-
    calcular_inss(INSS),
    calcular_irrf(IRRF),
    calcular_vale_transporte(VT),
    Total is INSS + IRRF + VT.

/* ===== REGRA 7: Cálculo do INSS (Progressivo) ===== */
calcular_inss(Desconto) :-
    calcular_salario_bruto(Bruto),
    teto_inss(Teto),
    desconto_maximo_inss(Max),
    ( Bruto >= Teto ->
        Desconto = Max
    ;
        calcular_inss_progressivo(Bruto, Desconto)
    ).

% Cálculo progressivo do INSS por faixas
calcular_inss_progressivo(Salario, Total) :-
    findall(Valor, (
        faixa_inss(_, Min, Max, Aliq),
        ( Salario > Max ->
            Base is Max - Min,
            Valor is Base * Aliq
        ; Salario > Min ->
            Base is Salario - Min,
            Valor is Base * Aliq
        ;
            Valor is 0
        )
    ), Valores),
    sumlist(Valores, Total).

/* ===== REGRA 8: Cálculo do IRRF (Progressivo) ===== */
calcular_irrf(Desconto) :-
    calcular_salario_bruto(Bruto),
    calcular_inss(INSS),
    obs(dependentes(Dep)),
    deducao_dependente(ValorDep),
    BaseCalculo is Bruto - INSS - (Dep * ValorDep),
    ( BaseCalculo =< 0 ->
        Desconto = 0
    ;
        calcular_irrf_faixa(BaseCalculo, Desconto)
    ).

% Identifica faixa de IRRF e aplica alíquota com dedução
calcular_irrf_faixa(Base, Desconto) :-
    faixa_irrf(_, Min, Max, Aliq, Deducao),
    Base >= Min,
    Base =< Max,
    Temp is Base * Aliq - Deducao,
    ( Temp < 0 -> Desconto = 0 ; Desconto = Temp ), !.

/* ===== REGRA 9: Cálculo de Vale Transporte ===== */
% Vale transporte: desconto de 6% se solicitado, limitado ao valor do VT
calcular_vale_transporte(Desconto) :-
    obs(vale_transporte(sim)),
    obs(salario_base(Base)),
    percentual_vale_transporte(Perc),
    obs(valor_vt(ValorVT)),
    DescontoCalc is Base * Perc,
    ( DescontoCalc > ValorVT ->
        Desconto = ValorVT
    ;
        Desconto = DescontoCalc
    ), !.
calcular_vale_transporte(0).

/* ===== REGRA 10: Cálculo do Salário Líquido ===== */
% Salário líquido = salário bruto + proventos - descontos
calcular_salario_liquido(Bruto, Proventos, Descontos, Liquido) :-
    Liquido is Bruto + Proventos - Descontos.