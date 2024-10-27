# Lista de Projeto 03 - Circuitos Digitais
Projeto direcionado à disciplina de Circuitos Digitais, ministrada pelo Prof Dr Pedro Thiago Valério de Souza no período 2024.1, na Universidade Federal Rural do Semi-Árido (UFERSA).

# Autores 
- Caio Barreto Meyer | [Caio B. Meyer](https://github.com/TaiCaio) 
- Guilherme Gabriel Saldanha Pereira | [OGuilhermeGabriel](https://github.com/OGuilhermeGabriel)

# Sumário 
- [Problema 01](#problema-01)
- [Problema 02](#problema-02)
- [Problema 03](#problema-03)
- [Problema 04](#problema-04)
- [Problema 05](#problema-05)

# Lista de Projetos

Implemente os seguintes circuitos em SystemVerilog utilizando qualquer abordagem:

# Problema 01
Flip-Flop D com entrada de reset assíncrono.

## Resolução 

Um Flip-Flop tipo D pode ser caracterizado da seguinte forma abaixo:

![FFd](/Problema%2001/Assets/FFd.jpg)

Note que, temos a saída *q* e, além das entradas de dados *d* e de clock *clk*, também temos a entrada assincrona do reset.

Para que seja possível realizar a lógica do Flip-Flop, será necessário utilizar a abordagem comportamental pois como o FF opera sob gatilhos de clock, serpa necessário criar um procedimento *always* para descreve-lo tanto em função dos gatilhos do clk (especificamente adotei como borda de subida) como também para quando o rst assíncrono for ativado.

## Descrição em *systemverilog*
~~~
module ffd (
    //declarando as entradas e saídas do ff-d
    input logic clk, rst,
    input logic d,
    output logic  q
);

    //é preciso utilizar a abordagem comportamental, pois como o ff opera sob gatilhos de clk, será necessário criar um procedimento always para descreve-lo. 

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            q <= 0; //caso rst = 1, a saída do ff será 0 => independente do gatilho do clk. Ou seja, "rst" é um reset assíncrono   
        else
            q <= d; //caso rst = 0 (rst != 1), acontece a lógica do ff-d (q = d) 
    end

endmodule
~~~

Note que durante o procedimento *always*, ele tem sensibilidade OU na borda de subida do *clk* OU quando o reset for ativado (*rst* = 1). Ou seja, independentemente do *clk*, caso o *rst* for 1, o FF reseta independentemente do próximo gatilho de *clk*, caracterizando ele como um reset assíncrono.

# Problema 02
Flip-Flop JK com entrada de reset assíncrono;

## Resolução 

Um Flip-Flop tipo JK pode ser caracterizado da seguinte forma abaixo:

![FFjk](/Problema%2002/Assets/FFjk.jpg)

## Descrição em *systemverilog*

# Problema 03
Uma máquina de estados que represente o seguinte comportamento: Projete uma máquina de estados que tem uma entrada gcnt e três saídas, *x*, *y* e *z*. As saídas *xyz* geram uma sequência chamada “código Gray” em que exatamente uma das três saídas muda de 0 para 1 ou de 1 para 0. A sequência em código Grau que a MdE deve produzir é 000, 010, 011, 001, 101, 111, 110, 100 voltando a se repetir. A saída deve mudar apenas na borda de subida do relógio quando *gcnt* = 1. Faça 000 ser o estado inicial.

## Resolução 

## Descrição em *systemverilog*

# Problema 04
Um registrador de 4 bits de carga paralela, de tal forma que quando *load* = 1, realiza-se a carga paralela e quando *clr* = 1, a saída do registrador é zerada, independente do sinal de relógio.

## Resolução 

## Descrição em *systemverilog*

# Problema 05
Um contador up/down counter de 8 bits. Quando *M* = 1, realiza-se a contagem crescente. Quando *M* = 0, realiza-se a contagem decrescente.

## Resolução 

## Descrição em *systemverilog*