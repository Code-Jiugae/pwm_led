`timescale 1ns / 1ps

module comparator(
        input [9:0] i_counter, //0~999 counter
        output [3:0] o_light
    );

    assign o_light[0] = (i_counter < 300) ? 1'b1 : 1'b0;
    assign o_light[1] = (i_counter < 600) ? 1'b1 : 1'b0;
    assign o_light[2] = (i_counter < 800) ? 1'b1 : 1'b0;
    assign o_light[3] = (i_counter < 900) ? 1'b1 : 1'b0;


endmodule
