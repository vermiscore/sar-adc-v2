`timescale 1ns/1ps
module sar_logic_tb;
    reg clk, rst, comp_out;
    wire b3, b2, b1, b0, eoc;

    sar_logic uut(.clk(clk),.rst(rst),.comp_out(comp_out),.b3(b3),.b2(b2),.b1(b1),.b0(b0),.eoc(eoc));

    always #5 clk = ~clk;

    // 毎クロック状態を表示
    always @(posedge clk) begin
        $display("t=%0t state=%0d comp=%b b3=%b b2=%b b1=%b b0=%b eoc=%b",
                 $time, uut.state, comp_out, b3, b2, b1, b0, eoc);
    end

    initial begin
        clk=0; rst=1; comp_out=0;
        #12 rst=0;
        @(posedge clk); #1; comp_out=1;
        @(posedge clk); #1; comp_out=0;
        @(posedge clk); #1; comp_out=1;
        @(posedge clk); #1; comp_out=0;
        @(posedge clk); #1;
        #10 $finish;
    end
endmodule
