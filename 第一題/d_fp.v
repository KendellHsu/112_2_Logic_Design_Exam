module DFP(
  input D, 
  input clk,
  input rin,
  input L,
  output Q);

// when L == 1, update Q_new as rin or stay at D, which is Q_old

reg q=0;
assign Q = q;
always @(posedge clk) begin
    // q <= D; only D flip flop
    q <= (L == 1'd1) ? rin : D; // reg use <= to update value
end

endmodule