module hw2_2(inputA, inputB, R01, R02, R91, R92, QA, QB, QC, QD);

input inputA, inputB, R01, R02, R91, R92;
output QA, QB, QC, QD;

// Preset
wire w1, Preset, w2, Clear;
and(w1, R91, R92);
not(Preset, w1);
//Clear
and(w2, R01, R02);
not(Clear, w2);

wire [3:0] Q;
wire [3:0] Q_bar;
JK jk1(1'd1, inputA, 1'd1, ~Preset, ~Clear, Q[0], Q_bar[0]);
JK jk2(Q_bar[3], inputB, 1'd1, 1'd0, ~(Clear&Preset), Q[1], Q_bar[1]);
JK jk3(1'd1, Q[1], 1'd1, 1'd0, ~(Clear&Preset), Q[2], Q_bar[2]);
JK jk4((Q[1]& Q[2]), inputB,Q[3],  ~Preset, ~Clear,Q[3], Q_bar[3]);

assign QA = Q[0];
assign QB = Q[1];
assign QC = Q[2];
assign QD = Q[3];

endmodule

/*
  Truth Table
  -------------------------------------------------------------
  | Preset | Clear | CLK | J | K | Output         | qo  | ~qo |
  -------------------------------------------------------------
  | 0      | 0     | x   | x | x | Invalid        | x   | x   |
  | 0      | 0     | NEG | 0 | 0 | Hold           | qo  | ~qo |
  | 0      | 0     | NEG | 0 | 1 | Reset          | 0   | 1   |
  | 0      | 0     | NEG | 1 | 0 | Set            | 1   | 0   |
  | 0      | 0     | NEG | 1 | 1 | Toggle         | ~qo | qo  |
  | 1      | 0     | x   | x | x | Preset         | 1   | 0   |
  | 0      | 1     | x   | x | x | Clear          | 0   | 1   |
  | 1      | 1     | x   | x | x | No change      | qo  | ~qo |
  -------------------------------------------------------------
*/