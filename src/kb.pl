% kb.pl - Base de conhecimento com fatos e tabelas

% Faixas de INSS 2024 (alíquotas progressivas)
faixa_inss(1, 0, 1412.00, 0.075).      % 7.5% até 1 salário mínimo
faixa_inss(2, 1412.01, 2666.68, 0.09). % 9% de 1 a 2 salários mínimos
faixa_inss(3, 2666.69, 4000.03, 0.12). % 12% de 2 a 3 salários mínimos
faixa_inss(4, 4000.04, 7786.02, 0.14). % 14% acima de 3 salários mínimos

% Teto máximo de contribuição INSS
teto_inss(7786.02).
desconto_maximo_inss(908.85). % valor máximo descontado

% Faixas de IRRF 2024 (alíquotas progressivas)
faixa_irrf(1, 0, 2259.20, 0.00, 0).        % Isento
faixa_irrf(2, 2259.21, 2826.65, 0.075, 169.44).  % 7.5%
faixa_irrf(3, 2826.66, 3751.05, 0.15, 381.44).   % 15%
faixa_irrf(4, 3751.06, 4664.68, 0.225, 662.77).  % 22.5%
faixa_irrf(5, 4664.69, 999999.99, 0.275, 896.00). % 27.5%

% Valor de dedução por dependente para IRRF
deducao_dependente(189.59).

% Percentuais de adicional noturno e insalubridade
adicional_noturno(0.20).        % 20% sobre salário base
insalubridade_grau(minimo, 0.10).   % 10% do salário mínimo
insalubridade_grau(medio, 0.20).    % 20% do salário mínimo
insalubridade_grau(maximo, 0.40).   % 40% do salário mínimo

% Salário mínimo 2024
salario_minimo(1412.00).

% Vale transporte: desconto máximo de 6% do salário base
percentual_vale_transporte(0.06).

% Percentuais de bonificação por desempenho
bonus_desempenho(excelente, 0.15).  % 15%
bonus_desempenho(bom, 0.10).        % 10%
bonus_desempenho(regular, 0.05).    % 5%
bonus_desempenho(nao, 0.00).        % sem bônus