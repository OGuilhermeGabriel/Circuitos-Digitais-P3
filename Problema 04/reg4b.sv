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