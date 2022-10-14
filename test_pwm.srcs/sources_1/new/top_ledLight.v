`timescale 1ns / 1ps

module top_ledLight(
        input i_clk,
        input i_reset,
        input[2:0] i_btn,
        output [2:0] o_light,
        output o_result
    );

    wire[2:0] w_btn;
    wire[2:0] w_light_state;
    button_controller btn_cnt0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_btn[0]),
        .o_button(w_btn[0])
    );

    button_controller btn_cnt1(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_btn[1]),
        .o_button(w_btn[1])
    );

    button_controller btn_cnt2(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_btn[2]),
        .o_button(w_btn[2])
    );

    fsm_light fsm_light_module(
        .i_clk(i_clk), 
        .i_reset(i_reset),
        .i_btn(w_btn),
        .o_light(o_light),
        .o_light_state(w_light_state)
    );



    wire w_clk;
    clock_divider(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk)
    );
    
    wire[9:0] w_counter;
    counter cnt(
        .i_clk(w_clk),
        .i_reset(i_reset),
        .o_counter(w_counter)
    );

    wire[3:0] w_light;
    comparator compare(
        .i_counter(w_counter), //0~999 counter
        .o_light(w_light)
    );

    mux mux_module(
        .i_x(w_light),
        .i_sel(w_light_state),
        .o_y(o_result)
    );
endmodule
