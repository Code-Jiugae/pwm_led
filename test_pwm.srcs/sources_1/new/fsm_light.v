`timescale 1ns / 1ps

module fsm_light(
        input i_clk, i_reset,
        // input[1:0] i_OnOffSw,
        input [2:0] i_btn,  // 0:up 1:down 2:off
        output[2:0] o_light,
        output[2:0] o_light_state
    );

    parameter   S_LED_000    = 3'b000,
                S_LED_001    = 3'b001,
                S_LED_010    = 3'b010,
                S_LED_011    = 3'b011,
                S_LED_100    = 3'b100;

    reg[2:0] currentState, nextState;
    reg[2:0] r_light;
    reg[2:0] r_light_state;
    
    assign o_light = r_light;
    assign o_light_state = r_light_state;

//apply event changes
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) currentState <= S_LED_000;
        else currentState <= nextState;
    end

// event processing
    always @(currentState or i_btn) begin
        case (currentState)
            S_LED_000   : begin
                if  (i_btn[0]) nextState <= S_LED_001;
                else if(i_btn[1]) nextState <= S_LED_000;
                else nextState <= S_LED_000;
            end

            S_LED_001    : begin
                if  (i_btn[0]) nextState <= S_LED_010;
                else if(i_btn[1]) nextState <= S_LED_000;
                else if(i_btn[2]) nextState <= S_LED_000;
                else nextState <= S_LED_001;
            end

            S_LED_010    : begin
                if  (i_btn[0]) nextState <= S_LED_011;
                else if(i_btn[1]) nextState <= S_LED_001;
                else if(i_btn[2]) nextState <= S_LED_000;
                else nextState <= S_LED_010;
            end

            S_LED_011    : begin
                if  (i_btn[0]) nextState <= S_LED_100;
                else if(i_btn[1]) nextState <= S_LED_010;
                else if(i_btn[2]) nextState <= S_LED_000;
                else nextState <= S_LED_011;
            end

            S_LED_100    : begin
                if  (i_btn[0]) nextState <= S_LED_100;
                else if(i_btn[1]) nextState <= S_LED_011;
                else if(i_btn[2]) nextState <= S_LED_000;
                else nextState <= S_LED_100;
            end
            default : nextState <= S_LED_000;
        endcase
    end

// Operation part depending on the condition
    always @(currentState) begin
        r_light <= 3'bxxx; // 'x'is floating state. 'z' is high impedence state.
        case (currentState)
            S_LED_000 : r_light <= 3'b000; 
            S_LED_001 : r_light <= 3'b001;
            S_LED_010 : r_light <= 3'b010;
            S_LED_011 : r_light <= 3'b011;
            S_LED_100 : r_light <= 3'b100;
            default : r_light <= 3'b000;
        endcase
        
    end

    always @(currentState) begin
        r_light_state <= 3'bxxx; // 'x'is floating state. 'z' is high impedence state.
        case (currentState)
            S_LED_000 : r_light_state <= 3'b000; 
            S_LED_001 : r_light_state <= 3'b001;
            S_LED_010 : r_light_state <= 3'b010;
            S_LED_011 : r_light_state <= 3'b011;
            S_LED_100 : r_light_state <= 3'b100;
            default : r_light_state <= 3'b000;
        endcase
        
    end
endmodule
