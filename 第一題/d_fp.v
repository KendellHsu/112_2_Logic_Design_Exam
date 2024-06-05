  module DFP(
    input D, 
    input clk,
    input rin,
    input L,
    output Q);


reg q=0;
assign Q = q;
always @(posedge clk) begin
    // q <= D; only D flip flop
    q <= (L == 1'd1) ? rin : D;
end

endmodule