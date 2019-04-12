`timescale 1ns / 1ns

module A;
	reg clk,rst,ld;
    reg [7:0] a,b;
    wire [7:0] sum;
    wire cout;
	serial_adder #(8) U( a,b,rst,ld,clk,sum,cout);
	
	initial begin
		clk = 1'b0;
		rst = 1'b1;
		ld  = 1'b0; 
        a   = 8'b11101010;
        b   = 8'b11110011;
	end
	always #10 clk = ~clk;
	initial begin
		#20
		rst = 1'b0;
		ld  = 1'b1;
		#160
		$stop();
		// sum = 11011101
		//cout = 1
	end
endmodule