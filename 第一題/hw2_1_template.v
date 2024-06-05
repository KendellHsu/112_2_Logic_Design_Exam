`include "d_fp.v"
module hw2_1 (
    input [2:0] R,
    input L,
    input clk,
    output [2:0] Qout // Q
    );

    wire [2:0] QQ;
    DFP d1(.D(QQ[2]), .clk(clk), .rin(R[0]), .L(L), .Q(QQ[0]));
    DFP d2(.D(QQ[0]), .clk(clk), .rin(R[1]), .L(L), .Q(QQ[1]));
    DFP d3(.D(QQ[2] ^ QQ[1]), .clk(clk), .rin(R[2]), .L(L), .Q(QQ[2]));
    
    assign Qout = QQ;

endmodule