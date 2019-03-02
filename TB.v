`timescale 1ns / 1ns

module A;
	reg clk,rst;
    reg [7:0] a,b;
    wire [7:0] sum;
    wire cout;
	serial_adder #(8) U( a,b,clk,rst,sum,cout);
	
	initial begin
		clk = 1'b0;
		rst = 1'b1;
        a   = 8'b11101010;
        b   = 8'b11110011;
	end
	always #10 clk = ~clk;
	initial begin
		#20
		rst = 1'b0;
		#160
		$stop();
	end
endmodule
