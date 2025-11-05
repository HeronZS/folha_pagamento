% main.pl - Orquestração do fluxo do sistema
% Carrega todos os módulos necessários
:- ["kb.pl","rules.pl","ui.pl","explain.pl"].

% Predicado principal que inicia o sistema
start :-
    banner, 
    menu.

% Exibe o banner com informações do sistema
banner :-
    format("~n================================================~n"),
    format("  Sistema Especialista - Folha de Pagamento~n"),
    format("================================================~n"),
    format("Desenvolvido por: [Seu Nome] (@seu-github)~n~n").

% Menu principal com opções para o usuário
menu :-
    format("~n--- MENU PRINCIPAL ---~n"),
    format("1) Executar consulta~n"),
    format("2) Sair~n"),
    format("> "),
    read(Opt),
    ( Opt = 1 -> 
        run_case, 
        cleanup, 
        menu
    ; Opt = 2 -> 
        format("~nSaindo do sistema...~n")
    ; 
        format("~nOpcao invalida. Tente novamente.~n"), 
        menu 
    ).

% Executa o cálculo da folha de pagamento
run_case :-
    format("~n=== CALCULO DE FOLHA DE PAGAMENTO ===~n~n"),
    coletar_dados_funcionario,
    ( meta(Resultado) ->
        explicar(Resultado),
        format("~n=== CALCULO CONCLUIDO ===~n")
    ; 
        format("~nNao foi possivel calcular a folha. Verifique os dados informados.~n")
    ),
    true.