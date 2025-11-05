Sistema Especialista - Folha de Pagamento

Sistema especialista desenvolvido em Prolog (SWI-Prolog) para cálculo automatizado de folha de pagamento, realizando inferências lógicas sobre proventos, descontos e salário líquido.

Desenvolvido por: Heron Zonta @HeronZS

Descrição

Este sistema modela regras e fatos da legislação trabalhista brasileira, permitindo o cálculo detalhado da folha de pagamento de funcionários.
A lógica do sistema é baseada em inferências automáticas, aplicando regras sobre INSS, IRRF, adicionais e bônus de desempenho.

Funcionalidades

Cálculo de salário bruto (base + adicionais)

Horas extras (50% de adicional)

Adicional noturno (20%)

Insalubridade (mínima, média e máxima)

Bônus por desempenho

Desconto progressivo de INSS

Desconto progressivo de IRRF (com dependentes)

Vale transporte (6% limitado)

Explicação das regras utilizadas no cálculo

Estrutura do Projeto
folha_pagamento/
├── src/
│   ├── main.pl      # Menu principal e controle do fluxo
│   ├── kb.pl        # Base de conhecimento (fatos e tabelas)
│   ├── rules.pl     # Regras de negócio
│   ├── ui.pl        # Interface para entrada de dados
│   └── explain.pl   # Explicação das inferências
└── README.md

Instalação e Configuração
Pré-requisitos

SWI-Prolog versão 8.0 ou superior

Instalação do SWI-Prolog

Windows

Baixe o instalador em: https://www.swi-prolog.org/download/stable

Siga as instruções do instalador

Adicione o SWI-Prolog ao PATH do sistema

Linux (Ubuntu/Debian)

sudo apt-get update
sudo apt-get install swi-prolog


macOS

brew install swi-prolog

Como Executar

Clone o repositório:

git clone https://github.com/HeronZS/folha_pagamento.git
cd folha-pagamento-prolog


Acesse o diretório do projeto:

cd folha_pagamento


Inicie o SWI-Prolog:

swipl


Carregue o sistema:

?- ['src/main.pl'].


Inicie a execução:

?- start.

Fluxo de Uso

Escolha a opção 1 para realizar o cálculo

Informe os dados solicitados:

Nome e cargo do funcionário

Salário base

Horas extras

Trabalho noturno (s/n)

Grau de insalubridade

Avaliação de desempenho

Número de dependentes

Vale transporte (s/n)

O sistema exibirá:

Composição do salário bruto

Proventos

Descontos

Salário líquido

Regras aplicadas

Exemplo de Uso
Exemplo 1 – Funcionário com adicionais

Entrada

Nome: joao_silva
Cargo: analista
Salário base: 4500.00
Horas extras: 10
Trabalho noturno: s
Insalubridade: nao
Desempenho: excelente
Dependentes: 2
Vale transporte: s
Valor VT: 250.00


Saída Esperada

--- COMPOSIÇÃO DO SALÁRIO BRUTO ---
Salário Base: R$ 4500.00
Horas Extras (10 horas): R$ 306.82
Adicional Noturno (20%): R$ 900.00
Salário Bruto: R$ 5706.82

--- PROVENTOS ---
Bônus por desempenho (15%): R$ 675.00

--- DESCONTOS ---
INSS: R$ 628.95
IRRF: R$ 389.73
Vale Transporte: R$ 250.00

Total de Descontos: R$ 1268.68
Salário Líquido: R$ 5113.14

Regras de Negócio
#	Regra	Descrição
1	Cálculo Salário Bruto	Base + horas extras + adicionais
2	Horas Extras	(Base / 220) × horas × 1.5
3	Adicional Noturno	20% sobre o salário base
4	Insalubridade	Percentual sobre o salário mínimo
5	Bônus de Desempenho	Percentual por avaliação
6	Total de Descontos	INSS + IRRF + VT
7	INSS Progressivo	Faixas de 7,5% a 14%
8	IRRF Progressivo	Faixas de 0% a 27,5%
9	Vale Transporte	6% limitado
10	Salário Líquido	Bruto + Proventos - Descontos
Tabelas Utilizadas
INSS 2024
Faixa	Base de Cálculo	Alíquota
1	até R$ 1.412,00	7,5%
2	R$ 1.412,01 – R$ 2.666,68	9%
3	R$ 2.666,69 – R$ 4.000,03	12%
4	R$ 4.000,04 – R$ 7.786,02	14%
Teto	R$ 908,85	—
IRRF 2024
Faixa	Base de Cálculo	Alíquota
1	até R$ 2.259,20	Isento
2	R$ 2.259,21 – R$ 2.826,65	7,5%
3	R$ 2.826,66 – R$ 3.751,05	15%
4	R$ 3.751,06 – R$ 4.664,68	22,5%
5	acima de R$ 4.664,69	27,5%
Dedução por dependente: R$ 189,59		
Conceitos Utilizados

Fatos: tabelas e percentuais definidos em kb.pl

Regras: inferências implementadas em rules.pl

Predicados dinâmicos: assert e retract

Unificação: casamento de padrões

Backtracking: busca por soluções

Cut (!): otimização de caminhos determinísticos

Limitações

Baseado na legislação de 2024

Não inclui periculosidade nem FGTS

Considera mês completo trabalhado

Sistema desenvolvido para fins educacionais

Contribuidores

Heron Zonta - @HeronZS

Licença

Este projeto foi desenvolvido para fins acadêmicos.

Instituição: UNIDAVI
Disciplina: Paradigmas de Programação
Ano: 2025