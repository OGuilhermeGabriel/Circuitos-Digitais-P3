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