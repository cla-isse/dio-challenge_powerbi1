# Olá, pessoa bonita! Tudo bem com você? 

![Static Badge](https://img.shields.io/badge/PowerBI-000?style=for-the-badge&logo=PowerBI)

Esta é a resolução do desafio "Processando e Transformando Dados com Power BI", o segundo da formação da formação "Visualização e Análise de Dados com Power BI", na plataforma [DIO](https://web.dio.me/home).

Mentor: [@julianamascarenhas](https://github.com/julianazanelatto)

## Sumário

[1. Criando um Relatório de Vendas Elegante com Power BI](/challenge1/README.md)

[2. Processando e Transformando com PowerBI](/challenge2/README.md)

---

### 1.1 Criação e Integração do Banco de Dados

1.	Criação de uma instância na Azure para MySQL
2.	Criar o Banco de dados com base disponível no github

O script contendo o passo a passo que eu utilizei para a criação do Banco de Dados está contido nesta pasta do GitHub. Tive alguns problemas na execução do script fornecido pela DIO, mas foi nele que eu me baseei.

3.	Integração do Power BI com MySQL no Azure 
4.	Verificar problemas na base a fim de realizar a transformação dos dados

### 1.2 Lista de Tarefas

- [x] Verifique os cabeçalhos e tipos de dados.
- [x] Modifique os valores monetários para o tipo double preciso.

```M
= Table.TransformColumnTypes(#"Removed Columns",{{"Salary", Currency.Type}})
```

- [x] Verifique a existência dos nulos e analise a remoção.

Employee
|Name|Ssn|Super_ssn |
|---|---|---|
|John | 888665555 | null |

> Os employees com nulos em Super_ssn podem ser os gerentes. Verifique se há algum colaborador sem gerente

- [x] Verifique se há algum departamento sem gerente
- [x] Se houver departamento sem gerente, suponha que você possui os dados e preencha as lacunas

Não há nenhum departamento sem gerente.

- [x] Verifique o número de horas dos projetos

- [x] Separar colunas complexas

Employee:
| Address | 
|---|
|731-Fondren-Houston-TX|
|638-Voss-Houston-TX|
|5631-Rice-Houston-TX|
|975-Fire-Oak-Humble-TX|
|...|

Nesse caso, todos os endereços possuem o mesmo formato, cujos blocos estão divididos pelo caractere "-".
> OBS: Será preciso ajustar a linha que contém "Oak-Humble" com a ferramenta "Replace Values".

![Split Column](/images/split_column.png)

Employee:
|StreetNo|Street|City|State|
|---|---|---|---|
|731|Fondren|Houston|TX|
|638|Voss|Houston|TX|
|5631|Rice|Houston|TX|
|975|Fire|Oak-Humble|TX|
|...|

- [x] Mesclar consultas employee e departament para criar uma tabela employee com o nome dos departamentos associados aos colaboradores. A mescla terá como base a tabela employee.
- [x] Nesse processo, elimine as colunas desnecessárias.

![Merge](/images/merge.png)
![Expand Merged Table](/images/expand_merged.png)

- [x] Realize a junção dos colaboradores e respectivos nomes dos gerentes. Isso pode ser feito com consulta SQL ou pela mescla de tabelas com Power BI. Caso utilize SQL, especifique no README a query utilizada no processo.

![Merge Employee Manager](/images/merge_employee_manager.png)
![Expand Merged Employee Manager](/images/expand_merged_employee_manager.png)

- [x] Mescle as colunas de Nome e Sobrenome para ter apenas uma coluna definindo os nomes dos colaboradores.

- [x] Mescle os nomes de departamentos e localização. Isso fará que cada combinação departamento-local seja único. Isso irá auxiliar na criação do modelo estrela em um módulo futuro.

- [x] Explique por que, neste caso supracitado, podemos apenas utilizar o mesclar e não o atribuir.

![Append](/images/append_example.png)

Ao utilizar o método append, no caso supracitado, o Power Query apenas combina as duas tabelas, sem levar em consideração a relação existente entre elas, a partir do número do departamento (Dnumer).

- [x] Agrupe os dados a fim de saber quantos colaboradores existem por gerente.

|Super_name|Super_ssn|Employees|
|---|---|---|
|Franklin Wong|333445555|3|
|James Borg|888665555|2|
|Jennifer Wallace|987654321|2|
||null|1|

- [x] Elimine as colunas desnecessárias, que não serão usadas no relatório, de cada tabela.