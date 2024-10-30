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

![FFd](/Problema%2001/Assets/FFd_NOVO.jpg)

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

Diferentemente do flip flop tipo D, outra lógica será aplicada para a implementação do flip flop tipo JK. Confira abaixo a sua respectiva tabela verdade, a qual relaciona as entredas JK com a saída Q, o *clk* for gatilhado pela borda de subida: 

| *J* | *K* | *Q* |
| --- | --- | --- |
|  0  |  0  | *Q* |
|  0  |  1  |  0  |
|  1  |  0  |  1  |
|  1  |  1  |*Q'* |


Note que agora será necessário implementar no procedimento "*always*" um case para descrever todas as quatro possibilidades descritas na tabela verdade 

## Descrição em *systemverilog*

~~~
module FFjk (
    //declarando as entradas e saídas do ff-jk
    input logic clk, rst,
    input logic j, k,
    // obs: "y" = q'
    output logic q, y
);
    // atribuindo à "y" o complemento da saída do ff-jk "q"
    assign y = ~q;
    // descrevendo a lógica do ffjk 
    always_ff @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            q <= 1'b0;
        end else begin // implementando a lógica do ff-jk 
            case ({j,k})
                2'b00 : q <= q; // mantém o estado
                2'b01 : q <= 1'b0; // reseta
                2'b10 : q <= 1'b1; // seta
                2'b11 : q <= ~q; // complementa
            endcase 
        end 
    end
    
endmodule
~~~

# Problema 03
Uma máquina de estados que represente o seguinte comportamento: Projete uma máquina de estados que tem uma entrada gcnt e três saídas, *x*, *y* e *z*. As saídas *xyz* geram uma sequência chamada “código Gray” em que exatamente uma das três saídas muda de 0 para 1 ou de 1 para 0. A sequência em código Grau que a MdE deve produzir é 000, 010, 011, 001, 101, 111, 110, 100 voltando a se repetir. A saída deve mudar apenas na borda de subida do relógio quando *gcnt* = 1. Faça 000 ser o estado inicial.

## Resolução 

Esta máquina de estados pode ser descrita tendo como base o seu diagrama de transição de estados, o qual pode ser interpretado da seguinte forma:

![diagrama_fsm](/Problema%2003/Assets/diagrama_fsm.jpg)

## Descrição em *systemverilog*
~~~
module mde (
    // declarando o clk e o rst 
    input logic clk, rst,
    // declarando as entradas e saídas da fsm 
    input logic gcnt, 
    // essa sequência de 3 bits será respectivamente xyz = b2b1b0
    output logic [2:0] saida  
);

    // DEFININDO A MÁQUINA DE ESTADOS 

    // 1) Definindo os estados da máquina de estados (e os tipos de variáveis de estados: t_state) - definirei aqui os estados da fsm
    typedef enum {a, b, c, d, e, f, g, h} t_state;
    // definindo as variáveis de estado próxima e atual tendo como base o tipo de variável "t_state"
    t_state currState, nextState; 

    // PROCEDIMENTO INICIAL 
    initial begin
        // definindo o estado "a" como o estado inicial
        currState = a;
        // estado a -> xyz = 000
        saida = 3'b000; 
    end 

    // 2) Registrador de estados

    always @(posedge clk, posedge rst) begin
        if (rst == 1'b1) begin
            currState = a;
        end
        else begin
            currState = nextState; 
        end 
    end 

    // 3) Lógica de estado próximo da fsm

    always @* begin
        case (currState)
            a : begin
                if (gcnt == 1'b1) nextState = b;
                else nextState = a; 
            end
            b : begin
                if (gcnt == 1'b1) nextState = c;
                else nextState = b; 
            end
            c : begin
                if (gcnt == 1'b1) nextState = d;
                else nextState = c; 
            end
            d : begin
                if (gcnt == 1'b1) nextState = e;
                else nextState = d; 
            end
            e : begin
                if (gcnt == 1'b1) nextState = f;
                else nextState = e; 
            end
            f : begin
                if (gcnt == 1'b1) nextState = g;
                else nextState = f; 
            end
            g : begin
                if (gcnt == 1'b1) nextState = h;
                else nextState = g; 
            end
            h : begin
                if (gcnt == 1'b1) nextState = a;
                else nextState = h; 
            end
        endcase  
    end 

    // 4) Lógica de saída próxima da fsm 

    always @* begin
        case(currState)
            a : begin
                saida = 3'b000;
            end
            b : begin
                saida = 3'b010;
            end
            c : begin
                saida = 3'b011;
            end
            d : begin
                saida = 3'b001;
            end
            e : begin
                saida = 3'b101;
            end
            f : begin
                saida = 3'b111;
            end
            g : begin
                saida = 3'b110;
            end
            h : begin
                saida = 3'b100;
            end
        endcase
    end
endmodule
~~~

Note que, para definir a máquina de estados, faz se necessária a implementação de 4 passos: 

- Passo 1: Definir os estados da máquina de estados 

Neste passo, serão definidos todos os estados que compõe a *fsm*. Onde cada estado é respectivamente uma combinação das saídas *xyz*.

- Passo 2: Registrador de estados

Aqui você irá definir a lógica padrão para que o corra a transição de estados. Ou seja, mudar do estado atual para o próximo estado. 

- Passo 3: Lógica de estado próximo

Como o nome do passo já diz, aqui você irá implementar a lógica do próximo estado da *fsm* tendo como base o estado atual que a máquina está situada. 

- Passou 4: Lógica de saída próxima 

Similar ao passo anterior, este passo é responsável por associar as saídas da máquina de estados com os seus respectivos estados. 

# Problema 04
Um registrador de 4 bits de carga paralela, de tal forma que quando *load* = 1, realiza-se a carga paralela e quando *clr* = 1, a saída do registrador é zerada, independente do sinal de relógio.

## Resolução 
Um registrador de 4 bits pode ser representado como uma conjunto de flip-flops tipo D interligados de forma síncrona ao *clk* como mostra abaixo: 

![reg_elementar](/Problema%2004/Assets/reg_elementar.jpg)

Mas, além disso, faz se necessário implementar dois sinais: o sinal de *clear* (*clr*) para zerar o registrador e o sinal de *load* (*ld*) para realizar a carga paralela. Ambos os sinais serão implementados na descrição, utilizando como base um registrador elementar de 4 bits.

## Descrição em *systemverilog*

~~~
module reg4b (
    // declarando as entradas e saídas do registrador de 4b
    input logic clk, clr, ld,
    // entrada do reg_4b = 4 entradas dos ff-d
    input logic [3:0] d,
    // saída do reg_4b = 4 saídas dos ff-d
    output logic [3:0] q
);

    // implementando a lógica sequencial do registrador
    always_ff @(posedge clk or posedge clr) begin
        if (clr == 1'b1)
            // clr = 1 -> zera o registrador (zera os ff-d's)
            q <= 4'b0000;   
        else if (ld)
            // a saída do registrador recebe os dados da entrada [Carga Paralela]
            q <= d;  
    end 
endmodule
~~~

# Problema 05
Um contador *up/down counter* de 8 bits. Quando *M* = 1, realiza-se a contagem crescente. Quando *M* = 0, realiza-se a contagem decrescente.

## Resolução 

Um contador *up/down counter* é um contador que hora vai contar em ordem crescente, incrementando os valores e hora vai contar de forma decrescente, decrementando os valores. O que irá definir se no momento ele irá incrementar ou decrementar é justamente o sinal de controle *M* localizado na entrada do contador. 

## Descrição em *systemverilog*

~~~
module counterupdown (
    // implementados as entradas e saídas do controlador 
    input logic clk, rst, 
    // implementando o sinal de controle M
    input logic M,
    // saída em 8 bits do contador 
    output logic [7:0] count 
);

    // implementando a lógica sequencial do contador 
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 8'b00000000; // resetando o contador 
        end else begin
            if (M == 1'b1) begin
                count <= count + 1; // M = 1 -> incrementa  
            end else begin
                count <= count - 1; // M = 0 -> decrementa 
            end  
        end 
    end
endmodule 
~~~