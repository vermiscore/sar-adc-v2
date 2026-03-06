module sar_logic (
    input  wire clk,
    input  wire rst,
    input  wire comp_out,
    output reg  b3,
    output reg  b2,
    output reg  b1,
    output reg  b0,
    output reg  eoc
);
    reg [2:0] state;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            b3<=0; b2<=0; b1<=0; b0<=0; eoc<=0; state<=0;
        end else begin
            case (state)
                3'd0: begin b3<=1; b2<=0; b1<=0; b0<=0; eoc<=0; state<=3'd1; end
                3'd1: begin b3<=comp_out; b2<=1; state<=3'd2; end
                3'd2: begin b2<=comp_out; b1<=1; state<=3'd3; end
                3'd3: begin b1<=comp_out; b0<=1; state<=3'd4; end
                3'd4: begin b0<=comp_out; eoc<=1; state<=3'd0; end
                default: state<=3'd0;
            endcase
        end
    end
endmodule
