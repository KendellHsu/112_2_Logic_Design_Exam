module JK(
    input J,
    input clk,
    input K,
    input Preset, 
    input Clear,
    output Q,
    output Q_bar);

    // 排成下面增值表的樣子比較好看Ｑ

/*
  Truth Table
  -------------------------------------------------------------
  | Preset | Clear | CLK | J | K | Output         | qo  | ~qo |
  -------------------------------------------------------------
  | 0      | 0     | x   | x | x | Invalid        | x   | x   |  do nothing
  | 0      | 0     | NEG | 0 | 0 | Hold           | qo  | ~qo |
  | 0      | 0     | NEG | 0 | 1 | Reset          | 0   | 1   |
  | 0      | 0     | NEG | 1 | 0 | Set            | 1   | 0   |
  | 0      | 0     | NEG | 1 | 1 | Toggle         | ~qo | qo  |
  | 1      | 0     | x   | x | x | Preset         | 1   | 0   |
  | 0      | 1     | x   | x | x | Clear          | 0   | 1   |
  | 1      | 1     | x   | x | x | No change      | qo  | ~qo |
  -------------------------------------------------------------
*/

// Flip-flop behavior
reg q;
assign Q = q;
assign Q_bar = ~q;

// Sol1
always @(negedge clk or posedge Preset or posedge Clear) begin
        case({Preset, Clear})
            2'b10: q <= 1'b1;   // Preset
            2'b01: q <= 1'b0;   // Clear Mode:Q is cleared to 0
            2'b11: q <= q;      // nothing change
            2'b00: begin
                case({J, K})
                    2'b00: q <= q;    // Hold
                    2'b01: q <= 1'b0; // Reset
                    2'b10: q <= 1'b1; // Set
                    2'b11: q <= ~q;   // Toggle
                endcase
            end
        endcase
        end
endmodule

// Sol2 Fake Curcuit, realize will have Latch
// always @(*) begin
//     case({Preset, Clear})
//         2'b11: q <= q;      // nothing change
//         2'b01: q <= 1'b0;   // Clear Mode:Q is cleared to 0
//         2'b10: q <= 1'b1;
//     endcase
// end

// always @(negedge clk) begin
//         case({Preset,Clear})
//             2'd0: begin
//                 case({J, K})
//                     2'b00: q <= q; // Hold
//                     2'b01: q <= 1'b0; // Reset
//                     2'b10: q <= 1'b1; // Set
//                     2'b11: q <= ~q; // Toggle
//                 endcase
//             end
//         endcase
//         end
// endmodule
