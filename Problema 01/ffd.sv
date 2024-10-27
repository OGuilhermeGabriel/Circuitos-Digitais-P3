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