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