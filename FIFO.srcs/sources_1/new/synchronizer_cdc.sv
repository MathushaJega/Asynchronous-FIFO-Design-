module synchronizer #(parameter WIDTH=3) (input clk, rst_n, [WIDTH:0] d_in, output reg [WIDTH:0] d_out);
  reg [WIDTH:0] q1;

  // Asynchronous reset is required so that VC-Spyglass fully
  // recognises this as a standard 2-FF CDC synchroniser cell.
  always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      q1    <= 0;
      d_out <= 0;
    end
    else begin
      q1    <= d_in;   // first  flip-flop stage
      d_out <= q1;     // second flip-flop stage
    end
  end
endmodule
