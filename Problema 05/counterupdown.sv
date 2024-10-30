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