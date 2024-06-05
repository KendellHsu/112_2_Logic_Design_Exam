module hw2_3 (
    // input is input
    input clk,
    input reset,
    input coin,
    input button,
    output reg[1:0] state,
    output reg candy);
    
    reg [1:0] current_state, next_state;
    //reg [1:0] CS, NS;

     parameter IDLE = 2'b00, COIN = 2'b01, DISPENSED = 2'b10; // parameter only save value ( like length )
    
    // Sol 1
    // always @(posedge clk or posedge reset) begin
    //     if(reset) begin 
    //         current_state <= IDLE;
    //         candy <= 1'd0;
    //         state <= IDLE;
    //     end 
    //     else begin
    //         case( current_state )
    //             IDLE : begin
    //                 current_state <= (coin == 1'd1 && button == 1'd1) ? DISPENSED : (coin == 1'd1) ? COIN : IDLE ;
    //             end

    //             COIN : begin
    //                 current_state <= (button == 1'd1) ? DISPENSED : COIN;
    //             end

    //             DISPENSED : begin 
    //                 current_state <= (coin == 1'd1) ? COIN : IDLE;
    //             end
    //         endcase
    //     end
    // end

    // always @(*) begin
    //     state = current_state;
    //     candy = (current_state == DISPENSED) ? 1'd1: 1'd0; 
    // end

    // Sol 2
    always @(posedge clk or posedge reset) begin
        if(reset) current_state <= IDLE;
        else      current_state <= next_state;
    end


    always @(*) begin
        case(current_state)
                IDLE : begin
                    next_state <= (coin == 1'd1 && button == 1'd1) ? DISPENSED : (coin == 1'd1) ? COIN : IDLE ;

                end
                COIN : begin
                    next_state <= (button == 1'd1) ? DISPENSED : COIN;

                end

                DISPENSED : begin 
                    next_state <= (coin == 1'd1) ? COIN : IDLE;

                end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if(reset) state <= IDLE;
        else      state <= next_state;
    end

    always @(posedge clk or posedge reset) begin
        if(reset) candy <= 1'd0;
        else      candy <= (next_state == DISPENSED)? 1'd1: 1'd0;
    end
endmodule