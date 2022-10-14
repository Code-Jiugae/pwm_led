`timescale 1ns / 1ps

module button_controller(
        input i_clk,
        input i_reset,
        input i_button,
        output o_button
    );

    parameter   PUSHED = 1'b1,
                RELEASED = 1'b0,
                TRUE = 1'b1,
                FALSE = 1'b0;

    parameter   DEBOUNCE = 500_000; // 10ms (100MHZ 기준)

    reg r_prevState = RELEASED;
    reg r_button;
    
    reg [31:0] r_counter = 0;

    assign o_button = r_button;

    always @(posedge i_clk or posedge i_reset) begin // sensitivity list에 있으면 비동기식 방식, 없으면 동기방식
        if(i_reset) begin
            r_button <= FALSE;
            r_prevState <= RELEASED;
            r_counter <= 0;
        end
        else begin
            if((i_button == PUSHED) && (r_prevState == RELEASED) && (r_counter < DEBOUNCE)) begin
                r_counter <= r_counter + 1;
                r_button <= FALSE;
            end
            else if((i_button == PUSHED) && (r_prevState == RELEASED) && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prevState <= PUSHED;
                r_button <= FALSE;
            end
            else if((i_button == RELEASED) && (r_prevState == PUSHED) && (r_counter < DEBOUNCE)) begin
                r_counter <= r_counter + 1;
                r_button <= FALSE;
            end
            else if((i_button == RELEASED) && (r_prevState == PUSHED) && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prevState <= RELEASED;
                r_button <= TRUE;
            end
            else begin
                r_button <= FALSE;
            end
        end
    end
endmodule
