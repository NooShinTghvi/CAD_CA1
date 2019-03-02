module serial_adder #(parameter N = 4) (
        input [N-1:0] a,b,
        input clk,rst,
        output [N-1:0] sum,
        output cout
    );
    wire carry_in,carry_out,a_out,b_out,sum_in;
    shift_register_out #(N) c1 (clk,rst,a,a_cout);
    shift_register_out #(N) c2 (clk,rst,b,b_cout);
    assign {carry_out,sum_in} = a_cout + b_cout + carry_in;
    Dff c3(clk,rst,carry_out,carry_in);
    shift_register_in #(N) c4 (clk,rst,sum_in,sum);
    assign cout = carry_out;
endmodule

module shift_register_out #(parameter N = 4) (
        input clk,rst,
        input [N-1:0] q,
        output y_out
    );
    wire [N-1:0] q_next,q_input;
    assign  q_next =    rst? 0 :
                        ~clk ? {q_input[0],q_input[N-1:1]} :
                        q_next;
    assign  q_input =   rst? q :
                        clk ? q_next :
                        q_input;
    assign y_out    = rst ? 0 :
                        ~clk ? q_input[0] :
                        y_out;
endmodule

module shift_register_in #(parameter N = 4) (
        input clk,rst,y_in,
        output [N-1:0] y
    );
    wire [N-1:0] temp;
    assign  temp = rst? 0 :
                    ~clk ? {y_in,y[N-1:1]} :
                    temp;
    assign  y    =  rst? 0 :
                    clk ? temp :
                    y;
endmodule

module Dff (
    input clk,rst,in_dff,
    output out_dff
);
    wire out_next;
    assign  out_next =  rst? 0 :
                        clk ? in_dff:
                        out_next;
    assign  out_dff =   rst? 0 :
                        ~clk ? out_next :
                        out_dff;
endmodule